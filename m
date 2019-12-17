Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 130371226B4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 09:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfLQIb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 03:31:26 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:60787 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfLQIbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576571485; x=1608107485;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=yaCCpNmgt5dSoQPGblWjHYjeIUxTXhnRUwlNrk8CnRw=;
  b=Ur6QkEnkpzfE2TAukNaByI+MFT5rsfx4JO/nvvGsXpi5yiB+wO66tBM0
   1yBq49HkZ6ObJmFgDLHSyBp+2tWdu1BP2syhtMR9lcvsTweiecXUaG1Ub
   RzWocIaeF9Tf7vRJzvkiWMDvUocN8u0OMBXLAZ+tmwQf052VCH6IfWeBi
   0=;
IronPort-SDR: qlMQyxHyUynkXHtberbg7XaHg+mK9a/9sUkc7P2uGjez8l17ICqpNSggSUiOHNDOGvUtEU8GdO
 Jqh+qqt/p9zw==
X-IronPort-AV: E=Sophos;i="5.69,324,1571702400"; 
   d="scan'208";a="8816134"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 17 Dec 2019 08:31:13 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 981D8A2A79;
        Tue, 17 Dec 2019 08:31:10 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 17 Dec 2019 08:31:10 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.100) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Dec 2019 08:31:05 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     =?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>
CC:     SeongJae Park <sjpark@amazon.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <konrad.wilk@oracle.com>,
        <pdurrant@amazon.com>, <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj38.park@gmail.com>,
        <xen-devel@lists.xenproject.org>, <roger.pau@citrix.com>
Subject: Re: Re: [Xen-devel] [PATCH v10 2/4] xen/blkback: Squeeze page pools if a memory pressure is detected
Date:   Tue, 17 Dec 2019 09:30:32 +0100
Message-ID: <20191217083032.19400-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <f9f686ce-aeca-0947-5b2b-91e1d0c183dd@suse.com> (raw)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D21UWB003.ant.amazon.com (10.43.161.212) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019 09:16:47 +0100 "Jürgen Groß" <jgross@suse.com> wrote:

> On 17.12.19 08:59, SeongJae Park wrote:
> > On Tue, 17 Dec 2019 07:23:12 +0100 "Jürgen Groß" <jgross@suse.com> wrote:
> > 
> >> On 16.12.19 20:48, SeongJae Park wrote:
> >>> On on, 16 Dec 2019 17:23:44 +0100, Jürgen Groß wrote:
> >>>
> >>>> On 16.12.19 17:15, SeongJae Park wrote:
> >>>>> On Mon, 16 Dec 2019 15:37:20 +0100 SeongJae Park <sjpark@amazon.com> wrote:
> >>>>>
> >>>>>> On Mon, 16 Dec 2019 13:45:25 +0100 SeongJae Park <sjpark@amazon.com> wrote:
> >>>>>>
> >>>>>>> From: SeongJae Park <sjpark@amazon.de>
> >>>>>>>
> >>>>> [...]
> >>>>>>> --- a/drivers/block/xen-blkback/xenbus.c
> >>>>>>> +++ b/drivers/block/xen-blkback/xenbus.c
> >>>>>>> @@ -824,6 +824,24 @@ static void frontend_changed(struct xenbus_device *dev,
> >>>>>>>     }
> >>>>>>>     
> >>>>>>>     
> >>>>>>> +/* Once a memory pressure is detected, squeeze free page pools for a while. */
> >>>>>>> +static unsigned int buffer_squeeze_duration_ms = 10;
> >>>>>>> +module_param_named(buffer_squeeze_duration_ms,
> >>>>>>> +		buffer_squeeze_duration_ms, int, 0644);
> >>>>>>> +MODULE_PARM_DESC(buffer_squeeze_duration_ms,
> >>>>>>> +"Duration in ms to squeeze pages buffer when a memory pressure is detected");
> >>>>>>> +
> >>>>>>> +/*
> >>>>>>> + * Callback received when the memory pressure is detected.
> >>>>>>> + */
> >>>>>>> +static void reclaim_memory(struct xenbus_device *dev)
> >>>>>>> +{
> >>>>>>> +	struct backend_info *be = dev_get_drvdata(&dev->dev);
> >>>>>>> +
> >>>>>>> +	be->blkif->buffer_squeeze_end = jiffies +
> >>>>>>> +		msecs_to_jiffies(buffer_squeeze_duration_ms);
> >>>>>>
> >>>>>> This callback might race with 'xen_blkbk_probe()'.  The race could result in
> >>>>>> __NULL dereferencing__, as 'xen_blkbk_probe()' sets '->blkif' after it links
> >>>>>> 'be' to the 'dev'.  Please _don't merge_ this patch now!
> >>>>>>
> >>>>>> I will do more test and share results.  Meanwhile, if you have any opinion,
> >>>>>> please let me know.
> >>>
> >>> I reduced system memory and attached bunch of devices in short time so that
> >>> memory pressure occurs while device attachments are ongoing.  Under this
> >>> circumstance, I was able to see the race.
> >>>
> >>>>>
> >>>>> Not only '->blkif', but 'be' itself also coule be a NULL.  As similar
> >>>>> concurrency issues could be in other drivers in their way, I suggest to change
> >>>>> the reclaim callback ('->reclaim_memory') to be called for each driver instead
> >>>>> of each device.  Then, each driver could be able to deal with its concurrency
> >>>>> issues by itself.
> >>>>
> >>>> Hmm, I don't like that. This would need to be changed back in case we
> >>>> add per-guest quota.
> >>>
> >>> Extending this callback in that way would be still not too hard.  We could use
> >>> the argument to the callback.  I would keep the argument of the callback to
> >>> 'struct device *' as is, and will add a comment saying 'NULL' value of the
> >>> argument means every devices.  As an example, xenbus would pass NULL-ending
> >>> array of the device pointers that need to free its resources.
> >>>
> >>> After seeing this race, I am now also thinking it could be better to delegate
> >>> detailed control of each device to its driver, as some drivers have some
> >>> complicated and unique relation with its devices.
> >>>
> >>>>
> >>>> Wouldn't a get_device() before calling the callback and a put_device()
> >>>> afterwards avoid that problem?
> >>>
> >>> I didn't used the reference count manipulation operations because other similar
> >>> parts also didn't.  But, if there is no implicit reference count guarantee, it
> >>> seems those operations are indeed necessary.
> >>>
> >>> That said, as get/put operations only adjust the reference count, those will
> >>> not make the callback to wait until the linking of the 'backend' and 'blkif' to
> >>> the device (xen_blkbk_probe()) is finished.  Thus, the race could still happen.
> >>> Or, am I missing something?
> >>
> >> No, I think we need a xenbus lock per device which will need to be
> >> taken in xen_blkbk_probe(), xenbus_dev_remove() and while calling the
> >> callback.
> > 
> > I also agree that locking should be used at last.  But, as each driver manages
> > its devices and resources in their way, it could have its unique race
> > conditions.  And, each unique race condition might have its unique efficient
> > way to synchronize it.  Therefore, I think the synchronization should be done
> > by each driver, not by xenbus and thus we should make the callback to be called
> > per-driver.
> 
> xenbus controls creation and removing of devices, so applying locking
> at xenbus level is the right thing to do in order to avoid races with
> device removal.
> 
> In case a backend has further synchronization requirements those have to
> be handled at backend level, of course.
> 
> In the end you'll need the xenbus level locking anyway in order to avoid
> a race when the last backend specific device is just being removed when
> the callback is about to be called for that device. Or you'd need to
> call try_get_module() before calling into each backend...

Agreed.  Thank you for your kind explanation of your concerns.


Thanks,
SeongJae Park

> 
> 
> Juergen
