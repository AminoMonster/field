<?php
/***************************************************************************
*                                                                          *
*   (c) 2004 Vladimir V. Kalynyak, Alexey V. Vinokurov, Ilya M. Shalnev    *
*                                                                          *
* This  is  commercial  software,  only  users  who have purchased a valid *
* license  and  accept  to the terms of the  License Agreement can install *
* and use this program.                                                    *
*                                                                          *
****************************************************************************
* PLEASE READ THE FULL TEXT  OF THE SOFTWARE  LICENSE   AGREEMENT  IN  THE *
* "copyright.txt" FILE PROVIDED WITH THIS DISTRIBUTION PACKAGE.            *
****************************************************************************/

namespace Tygh\Backend\Cache;

use Tygh\Registry;

class Redis extends ABackend
{
    /**
     * @var Redis
     */
    private $r;

    public function set($name, $data, $condition, $cache_level = NULL)
    {
        if (!empty($data)) {
            $this->r->hSet($this->_mapTags($name), $cache_level, array(
                'data' => $data,
                'expiry' => $cache_level == Registry::cacheLevel('time') ? TIME + $condition : 0
            ));
        }
    }

    public function get($name, $cache_level = NULL)
    {
        $data = $this->r->hGet($this->_mapTags($name), $cache_level);

        if (!empty($data)) {
            if (!empty($data) && ($cache_level != Registry::cacheLevel('time') || ($cache_level == Registry::cacheLevel('time') && $data['expiry'] > TIME))) {
                return array($data['data']);

            } else { // clean up the cache
                $this->r->del($this->_mapTags($name));
            }
        }

        return false;
    }

    public function clear($tags)
    {
        // clear method calls in shutdown function, so redis object can be destructed already
        if (empty($this->r)) {
            $this->_connect($this->_config);
        }

        if (!empty($tags)) {
            call_user_func_array(array($this->r, 'del'), $this->_mapTags($tags, 0));
        }

        return true;
    }

    public function saveHandlers($cache_handlers)
    {
        $this->r->hmSet($this->_mapTags($this->_handlers_name, 0), $cache_handlers);

        return true;
    }

    public function getHandlers()
    {
        return $this->r->hGetAll($this->_mapTags($this->_handlers_name, 0));
    }

    public function cleanup()
    {
        $keys = $this->r->keys($this->_mapTags('', 0) . '*');

        $this->r->del($keys);

        return true;
    }

    public function acquireLock($key, $cache_level)
    {
        $name = $key . $cache_level;

        if ($this->r->hsetnx($this->_mapTags('_locks'), $name, time() + Registry::LOCK_EXPIRY)) {
            return true;
        }

        if ($ttl = $this->r->hget($this->_mapTags('_locks'), $name)) {
            if ($ttl < time()) { // lock expired
                $this->r->hset($this->_mapTags('_locks'), $name, time() + Registry::LOCK_EXPIRY);

                return true;
            }
        }

        return false;
    }

    public function releaseLock($key, $cache_level)
    {
        $this->r->hdel($this->_mapTags('_locks'), $key . $cache_level);
    }

    public function __construct($config)
    {
        $this->_config = array(
            'redis_server' => $config['cache_redis_server'],
            'saas_uid' => !empty($config['saas_uid']) ? $config['saas_uid'] : null,
        );

        parent::__construct($config);

        if ($this->_connect($config)) {
            return true;
        }

        return false;
    }

    private function _connect()
    {
        $this->r = new \Redis();

        if ($this->r->connect($this->_config['redis_server']) == true) {
            $this->r->setOption(\Redis::OPT_SERIALIZER, \Redis::SERIALIZER_PHP);

            return true;
        }

        return false;
    }

    private function _mapTags($tags, $company_id = null)
    {
        if (!is_array($tags)) {
            $tags = array($tags);
            $return_one = true;
        }

        $company_id = !is_null($company_id) ? $company_id : $this->_company_id;
        $suffix = !empty($company_id) ? ($company_id . ':') : '';

        foreach ($tags as $k => $v) {
            $tags[$k] = 'cache:' . $this->_config['saas_uid'] . ':' . $suffix . $v;
        }

        return !empty($return_one) ? array_shift($tags) : $tags;
    }
}
