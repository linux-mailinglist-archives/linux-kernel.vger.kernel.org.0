Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 037AB17E02F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 13:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgCIMZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 08:25:46 -0400
Received: from foss.arm.com ([217.140.110.172]:51554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgCIMZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:25:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 126FD30E;
        Mon,  9 Mar 2020 05:25:45 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E748C3F6CF;
        Mon,  9 Mar 2020 05:25:39 -0700 (PDT)
Subject: Re: [PATCH v4 06/13] firmware: arm_scmi: Add notification
 callbacks-registration
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com
References: <20200304162558.48836-1-cristian.marussi@arm.com>
 <20200304162558.48836-7-cristian.marussi@arm.com>
 <20200309115006.00004e7a@Huawei.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <2b1fe67d-e4f5-491e-df89-ab7bebbb6788@arm.com>
Date:   Mon, 9 Mar 2020 12:25:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309115006.00004e7a@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2020 11:50, Jonathan Cameron wrote:
> On Wed, 4 Mar 2020 16:25:51 +0000
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
>> Add core SCMI Notifications callbacks-registration support: allow users
>> to register their own callbacks against the desired events.
>> Whenever a registration request is issued against a still non existent
>> event, mark such request as pending for later processing, in order to
>> account for possible late initializations of SCMI Protocols associated
>> to loadable drivers.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> Another one that you should run the kernel-doc scripts over. I haven't checked
> but fairly sure they won't like some of this...
> 

Sorry for that, I passed the series through cp sparse and lockdep but I completely
ignored kernel-doc building.


> Otherwise a few trivial things inline.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Thanks,
> 
> Jonathan
> 


>> ---
>> V3 --> V4
>> - split registered_handlers hashtable on a per-protocol basis to reduce
>>   unneeded contention
>> - introduced pending_handlers table and related late_init worker to finalize
>>   handlers registration upon effective protocols' registrations
>> - introduced further safe accessors macros for registered_protocols
>>   and registered_events arrays
>> V2 --> V3
>> - refactored get/put event_handler
>> - removed generic non-handle-based API
>> V1 --> V2
>> - splitted out of V1 patch 04
>> - moved from IDR maps to real HashTables to store event_handlers
>> - added proper enable_events refcounting via __scmi_enable_evt()
>>   [was broken in V1 when using ALL_SRCIDs notification chains]
>> - reviewed hashtable cleanup strategy in scmi_notifications_exit()
>> - added scmi_register_event_notifier()/scmi_unregister_event_notifier()
>>   to include/linux/scmi_protocol.h as a candidate user API
>>   [no EXPORTs still]
>> - added notify_ops to handle during initialization as an additional
>>   internal API for scmi_drivers
>> ---
>>  drivers/firmware/arm_scmi/notify.c | 700 +++++++++++++++++++++++++++++
>>  drivers/firmware/arm_scmi/notify.h |  12 +
>>  include/linux/scmi_protocol.h      |  50 +++
>>  3 files changed, 762 insertions(+)
>> +

[snip]
>> +/**
>> + * __scmi_enable_evt  - Enable/disable events generation
>> + *
>> + * Takes care of proper refcounting while performing enable/disable: handles
>> + * the special case of ALL sources requests by itself.
>> + *
>> + * @r_evt: The registered event to act upon
>> + * @src_id: The src_id to act upon
>> + * @enable: The action to perform: true->Enable, false->Disable
>> + *
>> + * Return: True when the required @action has been successfully executed
>> + */
>> +static inline bool __scmi_enable_evt(struct scmi_registered_event *r_evt,
>> +				     u32 src_id, bool enable)
>> +{
>> +	int ret = 0;
>> +	u32 num_sources;
>> +	refcount_t *sid;
>> +
>> +	if (src_id == SCMI_ALL_SRC_IDS) {
>> +		src_id = 0;
>> +		num_sources = r_evt->num_sources;
>> +	} else if (src_id < r_evt->num_sources) {
>> +		num_sources = 1;
>> +	} else {
>> +		return ret;
>> +	}
>> +
>> +	mutex_lock(&r_evt->sources_mtx);
>> +	if (enable) {
>> +		for (; num_sources; src_id++, num_sources--) {
>> +			bool r;
>> +
>> +			sid = &r_evt->sources[src_id];
>> +			if (refcount_read(sid) == 0) {
>> +				r = REVT_NOTIFY_ENABLE(r_evt,
>> +						       r_evt->evt->id,
>> +						       src_id, enable);
> 
> I would make the enable explicit in this call so it is obvious we are
> in the enable path rather than disable.
> 

Right, I'll use an explicit macro naming like REVY_NOTIFY_ENABLE/DISABLE

>> +				if (r)
>> +					refcount_set(sid, 1);
>> +			} else {
>> +				refcount_inc(sid);
>> +				r = true;
>> +			}
>> +			ret += r;
>> +		}
>> +	} else {
>> +		for (; num_sources; src_id++, num_sources--) {
>> +			sid = &r_evt->sources[src_id];
>> +			if (refcount_dec_and_test(sid))
>> +				REVT_NOTIFY_ENABLE(r_evt,
>> +						   r_evt->evt->id,
>> +						   src_id, enable);
> 
> As above, make the enable value explicit.
> 

I'll do.

Thanks

Cristian

>> +		}
>> +		ret = 1;
>> +	}
>> +	mutex_unlock(&r_evt->sources_mtx);
>> +
>> +	return ret;
>> +}
>> +
>> +static bool scmi_enable_events(struct scmi_event_handler *hndl)
>> +{
>> +	if (!hndl->enabled)
>> +		hndl->enabled = __scmi_enable_evt(hndl->r_evt,
>> +						  KEY_XTRACT_SRC_ID(hndl->key),
>> +						  true);
>> +	return hndl->enabled;
>> +}
>> +
>> +static bool scmi_disable_events(struct scmi_event_handler *hndl)
>> +{
>> +	if (hndl->enabled)
>> +		hndl->enabled = !__scmi_enable_evt(hndl->r_evt,
>> +						   KEY_XTRACT_SRC_ID(hndl->key),
>> +						   false);
>> +	return !hndl->enabled;
>> +}
>> +
>> +/**
>> + * scmi_put_handler_unlocked  - Put an event handler
>> + *
>> + * After having got exclusive access to the registered handlers hashtable,
>> + * update the refcount and if @hndl is no more in use by anyone:
>> + *
>> + *  - ask for events' generation disabling
>> + *  - unregister and free the handler itself
>> + *
>> + *  Assumes all the proper locking has been managed by the caller.
>> + *
>> + * @ni: A reference to the notification instance to use
>> + * @hndl: The event handler to act upon
>> + */
>> +
>> +static void
>> +scmi_put_handler_unlocked(struct scmi_notify_instance *ni,
>> +				struct scmi_event_handler *hndl)
>> +{
>> +	if (refcount_dec_and_test(&hndl->users)) {
>> +		if (likely(!IS_HNDL_PENDING(hndl)))
>> +			scmi_disable_events(hndl);
>> +		scmi_free_event_handler(hndl);
>> +	}
>> +}
>> +
>> +static void scmi_put_handler(struct scmi_notify_instance *ni,
>> +			     struct scmi_event_handler *hndl)
>> +{
>> +	struct scmi_registered_event *r_evt = hndl->r_evt;
>> +
>> +	mutex_lock(&ni->pending_mtx);
>> +	if (r_evt)
>> +		mutex_lock(&r_evt->proto->registered_mtx);
>> +
>> +	scmi_put_handler_unlocked(ni, hndl);
>> +
>> +	if (r_evt)
>> +		mutex_unlock(&r_evt->proto->registered_mtx);
>> +	mutex_unlock(&ni->pending_mtx);
>> +}
>> +
>> +/**
>> + * scmi_event_handler_enable_events  - Enable events associated to an handler
>> + *
>> + * @hndl: The Event handler to act upon
>> + *
>> + * Return: True on success
>> + */
>> +static bool scmi_event_handler_enable_events(struct scmi_event_handler *hndl)
>> +{
>> +	if (!scmi_enable_events(hndl)) {
>> +		pr_err("SCMI Notifications: Failed to ENABLE events for key:%X !\n",
>> +		       hndl->key);
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +/**
>> + * scmi_register_notifier  - Register a notifier_block for an event
>> + *
>> + * Generic helper to register a notifier_block against a protocol event.
>> + *
>> + * A notifier_block @nb will be registered for each distinct event identified
>> + * by the tuple (proto_id, evt_id, src_id) on a dedicated notification chain
>> + * so that:
>> + *
>> + *	(proto_X, evt_Y, src_Z) --> chain_X_Y_Z
>> + *
>> + * @src_id meaning is protocol specific and identifies the origin of the event
>> + * (like domain_id, sensor_id and so forth).
>> + *
>> + * @src_id can be NULL to signify that the caller is interested in receiving
>> + * notifications from ALL the available sources for that protocol OR simply that
>> + * the protocol does not support distinct sources.
>> + *
>> + * As soon as one user for the specified tuple appears, an handler is created,
>> + * and that specific event's generation is enabled at the platform level, unless
>> + * an associated registered event is found missing, meaning that the needed
>> + * protocol is still to be initialized and the handler has just been registered
>> + * as still pending.
>> + *
>> + * @handle: The handle identifying the platform instance against which the
>> + *	    callback is registered
>> + * @proto_id: Protocol ID
>> + * @evt_id: Event ID
>> + * @src_id: Source ID, when NULL register for events coming form ALL possible
>> + *	    sources
>> + * @nb: A standard notifier block to register for the specified event
>> + *
>> + * Return: Return 0 on Success
>> + */
>> +static int scmi_register_notifier(const struct scmi_handle *handle,
>> +				  u8 proto_id, u8 evt_id, u32 *src_id,
>> +				  struct notifier_block *nb)
>> +{
>> +	int ret = 0;
>> +	u32 evt_key;
>> +	struct scmi_event_handler *hndl;
>> +	struct scmi_notify_instance *ni = handle->notify_priv;
>> +
>> +	if (unlikely(!ni || !atomic_read(&ni->initialized)))
>> +		return 0;
>> +
>> +	evt_key = MAKE_HASH_KEY(proto_id, evt_id,
>> +				src_id ? *src_id : SCMI_ALL_SRC_IDS);
>> +	hndl = scmi_get_or_create_handler(ni, evt_key);
>> +	if (IS_ERR_OR_NULL(hndl))
>> +		return PTR_ERR(hndl);
>> +
>> +	blocking_notifier_chain_register(&hndl->chain, nb);
>> +
>> +	/* Enable events for not pending handlers */
>> +	if (likely(!IS_HNDL_PENDING(hndl))) {
>> +		if (!scmi_event_handler_enable_events(hndl)) {
>> +			scmi_put_handler(ni, hndl);
>> +			ret = -EINVAL;
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * scmi_unregister_notifier  - Unregister a notifier_block for an event
>> + *
>> + * Takes care to unregister the provided @nb from the notification chain
>> + * associated to the specified event and, if there are no more users for the
>> + * event handler, frees also the associated event handler structures.
>> + * (this could possibly cause disabling of event's generation at platform level)
>> + *
>> + * @handle: The handle identifying the platform instance against which the
>> + *	    callback is unregistered
>> + * @proto_id: Protocol ID
>> + * @evt_id: Event ID
>> + * @src_id: Source ID
>> + * @nb: The notifier_block to unregister
>> + *
>> + * Return: 0 on Success
>> + */
>> +static int scmi_unregister_notifier(const struct scmi_handle *handle,
>> +				    u8 proto_id, u8 evt_id, u32 *src_id,
>> +				    struct notifier_block *nb)
>> +{
>> +	u32 evt_key;
>> +	struct scmi_event_handler *hndl;
>> +	struct scmi_notify_instance *ni = handle->notify_priv;
>> +
>> +	if (unlikely(!ni || !atomic_read(&ni->initialized)))
>> +		return 0;
>> +
>> +	evt_key = MAKE_HASH_KEY(proto_id, evt_id,
>> +				src_id ? *src_id : SCMI_ALL_SRC_IDS);
>> +	hndl = scmi_get_handler(ni, evt_key);
>> +	if (IS_ERR_OR_NULL(hndl))
>> +		return -EINVAL;
>> +
>> +	blocking_notifier_chain_unregister(&hndl->chain, nb);
>> +	scmi_put_handler(ni, hndl);
>> +
>> +	/*
>> +	 * Free the handler (and stop events) if this happens to be the last
>> +	 * known user callback for this handler; a possible concurrently ongoing
>> +	 * run of @scmi_lookup_and_call_event_chain will cause this to happen
>> +	 * in that context safely instead.
>> +	 */
>> +	scmi_put_handler(ni, hndl);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * scmi_protocols_late_init  - Worker for late initialization
>> + *
>> + * This kicks in whenever a new protocol has completed its own registration via
>> + * scmi_register_protocol_events(): it is in charge of scanning the table of
>> + * pending handlers (registered by users while the related protocol was still
>> + * not initialized) and finalizing their initialization whenever possible;
>> + * invalid pending handlers are purged at this point in time.
>> + *
>> + * @work: The work item to use associated to the proper SCMI instance
>> + */
>> +static void scmi_protocols_late_init(struct work_struct *work)
>> +{
>> +	int bkt;
>> +	struct scmi_event_handler *hndl;
>> +	struct scmi_notify_instance *ni;
>> +	struct hlist_node *tmp;
>> +
>> +	ni = container_of(work, struct scmi_notify_instance, init_work);
>> +
>> +	mutex_lock(&ni->pending_mtx);
>> +	hash_for_each_safe(ni->pending_events_handlers, bkt, tmp, hndl, hash) {
>> +		bool ret;
>> +
>> +		ret = scmi_bind_event_handler(ni, hndl);
>> +		if (ret) {
>> +			pr_info("SCMI Notifications: finalized PENDING handler - key:%X\n",
>> +				hndl->key);
>> +			ret = scmi_event_handler_enable_events(hndl);
>> +		} else {
>> +			ret = scmi_valid_pending_handler(ni, hndl);
>> +		}
>> +		if (!ret) {
>> +			pr_info("SCMI Notifications: purging PENDING handler - key:%X\n",
>> +				hndl->key);
>> +			/* this hndl can be only a pending one */
>> +			scmi_put_handler_unlocked(ni, hndl);
>> +		}
>> +	}
>> +	mutex_unlock(&ni->pending_mtx);
>> +}
>> +
>> +/*
>> + * notify_ops are attached to the handle so that can be accessed
>> + * directly from an scmi_driver to register its own notifiers.
>> + */
>> +static struct scmi_notify_ops notify_ops = {
>> +	.register_event_notifier = scmi_register_notifier,
>> +	.unregister_event_notifier = scmi_unregister_notifier,
>> +};
>> +
>>  /**
>>   * scmi_notification_init  - Initializes Notification Core Support
>>   *
>> @@ -398,7 +1092,13 @@ int scmi_notification_init(struct scmi_handle *handle)
>>  	if (!ni->registered_protocols)
>>  		goto err;
>>  
>> +	mutex_init(&ni->pending_mtx);
>> +	hash_init(ni->pending_events_handlers);
>> +
>> +	INIT_WORK(&ni->init_work, scmi_protocols_late_init);
>> +
>>  	handle->notify_priv = ni;
>> +	handle->notify_ops = &notify_ops;
>>  
>>  	atomic_set(&ni->initialized, 1);
>>  	atomic_set(&ni->enabled, 1);
>> diff --git a/drivers/firmware/arm_scmi/notify.h b/drivers/firmware/arm_scmi/notify.h
>> index a7ece64e8842..f765acda2311 100644
>> --- a/drivers/firmware/arm_scmi/notify.h
>> +++ b/drivers/firmware/arm_scmi/notify.h
>> @@ -9,9 +9,21 @@
>>  #ifndef _SCMI_NOTIFY_H
>>  #define _SCMI_NOTIFY_H
>>  
>> +#include <linux/bug.h>
>>  #include <linux/device.h>
>>  #include <linux/types.h>
>>  
>> +#define MAP_EVT_TO_ENABLE_CMD(id, map)			\
>> +({							\
>> +	int ret = -1;					\
>> +							\
>> +	if (likely((id) < ARRAY_SIZE((map))))		\
>> +		ret = (map)[(id)];			\
>> +	else						\
>> +		WARN(1, "UN-KNOWN evt_id:%d\n", (id));	\
>> +	ret;						\
>> +})
>> +
>>  /**
>>   * scmi_event  - Describes an event to be supported
>>   *
>> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
>> index 0679f10ab05e..797e1e03ae52 100644
>> --- a/include/linux/scmi_protocol.h
>> +++ b/include/linux/scmi_protocol.h
>> @@ -9,6 +9,8 @@
>>  #define _LINUX_SCMI_PROTOCOL_H
>>  
>>  #include <linux/device.h>
>> +#include <linux/ktime.h>
>> +#include <linux/notifier.h>
>>  #include <linux/types.h>
>>  
>>  #define SCMI_MAX_STR_SIZE	16
>> @@ -211,6 +213,52 @@ struct scmi_reset_ops {
>>  	int (*deassert)(const struct scmi_handle *handle, u32 domain);
>>  };
>>  
>> +/**
>> + * scmi_notify_ops  - represents notifications' operations provided by SCMI core
>> + *
>> + * A user can register/unregister its own notifier_block against the wanted
>> + * platform instance regarding the desired event identified by the
>> + * tuple: (proto_id, evt_id, src_id)
>> + *
>> + * @register_event_notifier: Register a notifier_block for the requested event
>> + * @unregister_event_notifier: Unregister a notifier_block for the requested
>> + *			       event
>> + *
>> + * where:
>> + *
>> + * @handle: The handle identifying the platform instance to use
>> + * @proto_id: The protocol ID as in SCMI Specification
>> + * @evt_id: The message ID of the desired event as in SCMI Specification
>> + * @src_id: A pointer to the desired source ID if different sources are
>> + *	    possible for the protocol (like domain_id, sensor_id...etc)
>> + *
>> + * @src_id can be provided as NULL if it simply does NOT make sense for
>> + * the protocol at hand, OR if the user is explicitly interested in
>> + * receiving notifications from ANY existent source associated to the
>> + * specified proto_id / evt_id.
>> + *
>> + * Received notifications are finally delivered to the registered users,
>> + * invoking the callback provided with the notifier_block *nb as follows:
>> + *
>> + *	int user_cb(nb, evt_id, report)
>> + *
>> + * with:
>> + *
>> + * @nb: The notifier block provided by the user
>> + * @evt_id: The message ID of the delivered event
>> + * @report: A custom struct describing the specific event delivered
>> + *
>> + * Events' customized report structs are detailed in the following.
>> + */
>> +struct scmi_notify_ops {
>> +	int (*register_event_notifier)(const struct scmi_handle *handle,
>> +				       u8 proto_id, u8 evt_id, u32 *src_id,
>> +				       struct notifier_block *nb);
>> +	int (*unregister_event_notifier)(const struct scmi_handle *handle,
>> +					 u8 proto_id, u8 evt_id, u32 *src_id,
>> +					 struct notifier_block *nb);
>> +};
>> +
>>  /**
>>   * struct scmi_handle - Handle returned to ARM SCMI clients for usage.
>>   *
>> @@ -221,6 +269,7 @@ struct scmi_reset_ops {
>>   * @clk_ops: pointer to set of clock protocol operations
>>   * @sensor_ops: pointer to set of sensor protocol operations
>>   * @reset_ops: pointer to set of reset protocol operations
>> + * @notify_ops: pointer to set of notifications related operations
>>   * @perf_priv: pointer to private data structure specific to performance
>>   *	protocol(for internal use only)
>>   * @clk_priv: pointer to private data structure specific to clock
>> @@ -242,6 +291,7 @@ struct scmi_handle {
>>  	struct scmi_power_ops *power_ops;
>>  	struct scmi_sensor_ops *sensor_ops;
>>  	struct scmi_reset_ops *reset_ops;
>> +	struct scmi_notify_ops *notify_ops;
>>  	/* for protocol internal use */
>>  	void *perf_priv;
>>  	void *clk_priv;
> 
> 

