Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C02792DED3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 15:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfE2Ntb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 09:49:31 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44713 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfE2Ntb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:49:31 -0400
Received: by mail-qk1-f194.google.com with SMTP id w187so1443155qkb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Pq+EyzVMQUywjOkzMmPfTzQM4e0EdEY2GE/XNiKIwM=;
        b=M/zE/zUzf2NHNsmOi1WlLM7ggaufogVbv14p1kjnbzkN2KqvPl1S23nU/wKauqny2m
         bgbN+IN6aeJmZPzc80JfIpVFWP0pEZ5M9ZUNm3roKM7WGIkkxDPdcRGf9owSkfpkHhXr
         k7LyOXRxY84FpqITG3R1iy5s0ruot32UfYUO73SFr7lT3u0Ueg+QPDFY4LMshSWFQ83/
         mfABorq+A+/D5iUSEBGC6IeYPtdr9Efbk00DELTOFn2YL5tRq7uiMmJ7OEl2JQ6pgpjX
         OxWtZklMP7J8v5TFqbT93gx6AwI4wiSKaeYA+xjPTsgpIt9pyq2c5lKawLxqXjQ84I2c
         yUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Pq+EyzVMQUywjOkzMmPfTzQM4e0EdEY2GE/XNiKIwM=;
        b=qYCGL4aBpl9jWFJ7dsOGqcSbOIo1vqv60Vmcdw5IiDBMZAUnYYnARgqFmxC8lP7Fzz
         J2IZ8OYLm3JDwH7Ol2NfxBQgRiA4s/m/M7gXknQgIM3lCdhM/20BlObVQPtbzh6KnGHY
         9WqHKdIBj+n5DNdz/owTpIEq7wLZRK9+stFdjBwbbNApCjdeaW94jND1kNxBqIEFt9/t
         QxwfLI9qD0dad3hjbPBSdJAVHL/vj52fo9891ix38cH/9RBa0cIk+KcrvMMw6LXu9Ol5
         nysCJEIl03WDXcr8mV7cSdpSL1B7crksFzBfFRP/NqaOqTD74UWqksFUWM0x9n5YeC0Q
         j1vw==
X-Gm-Message-State: APjAAAWINk3grWfxq10Wg5B8kOKlAfBLpjy/tMmkJagSYG1AtFiKP4/0
        1OIPOjE+PSn0XqvydU6K9Aw4nMMjWSNdPg==
X-Google-Smtp-Source: APXvYqyVcViDCVP80pog0PmCySWfQPT3Fqwm8n4msm5wl7ow2Px/+9HWlia9g58hN9/VMgAZRGrvng==
X-Received: by 2002:a37:bb43:: with SMTP id l64mr94305733qkf.305.1559137769862;
        Wed, 29 May 2019 06:49:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d8f])
        by smtp.gmail.com with ESMTPSA id c4sm6132790qkd.24.2019.05.29.06.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 06:49:29 -0700 (PDT)
Date:   Wed, 29 May 2019 09:49:27 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yao Liu <yotta.liu@ucloud.cn>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        nbd <nbd@other.debian.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] nbd: fix connection timed out error after
 reconnecting to server
Message-ID: <20190529134925.mgp5drfn6ifr3u4g@MacBook-Pro-91.local>
References: <1558691036-16281-1-git-send-email-yotta.liu@ucloud.cn>
 <20190524130740.zfypc2j3q5e3gryr@MacBook-Pro-91.local.dhcp.thefacebook.com>
 <20190527180743.GA20702@192-168-150-246.7~>
 <20190528165758.zxfrv6fum4vwcv4e@MacBook-Pro-91.local>
 <20190528190446.GA21513@192-168-150-246.7~>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528190446.GA21513@192-168-150-246.7~>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 03:04:46AM +0800, Yao Liu wrote:
> On Tue, May 28, 2019 at 12:57:59PM -0400, Josef Bacik wrote:
> > On Tue, May 28, 2019 at 02:07:43AM +0800, Yao Liu wrote:
> > > On Fri, May 24, 2019 at 09:07:42AM -0400, Josef Bacik wrote:
> > > > On Fri, May 24, 2019 at 05:43:54PM +0800, Yao Liu wrote:
> > > > > Some I/O requests that have been sent succussfully but have not yet been
> > > > > replied won't be resubmitted after reconnecting because of server restart,
> > > > > so we add a list to track them.
> > > > > 
> > > > > Signed-off-by: Yao Liu <yotta.liu@ucloud.cn>
> > > > 
> > > > Nack, this is what the timeout stuff is supposed to handle.  The commands will
> > > > timeout and we'll resubmit them if we have alive sockets.  Thanks,
> > > > 
> > > > Josef
> > > > 
> > > 
> > > On the one hand, if num_connections == 1 and the only sock has dead,
> > > then we do nbd_genl_reconfigure to reconnect within dead_conn_timeout,
> > > nbd_xmit_timeout will not resubmit commands that have been sent
> > > succussfully but have not yet been replied. The log is as follows:
> > >  
> > > [270551.108746] block nbd0: Receive control failed (result -104)
> > > [270551.108747] block nbd0: Send control failed (result -32)
> > > [270551.108750] block nbd0: Request send failed, requeueing
> > > [270551.116207] block nbd0: Attempted send on invalid socket
> > > [270556.119584] block nbd0: reconnected socket
> > > [270581.161751] block nbd0: Connection timed out
> > > [270581.165038] block nbd0: shutting down sockets
> > > [270581.165041] print_req_error: I/O error, dev nbd0, sector 5123224 flags 8801
> > > [270581.165149] print_req_error: I/O error, dev nbd0, sector 5123232 flags 8801
> > > [270581.165580] block nbd0: Connection timed out
> > > [270581.165587] print_req_error: I/O error, dev nbd0, sector 844680 flags 8801
> > > [270581.166184] print_req_error: I/O error, dev nbd0, sector 5123240 flags 8801
> > > [270581.166554] block nbd0: Connection timed out
> > > [270581.166576] print_req_error: I/O error, dev nbd0, sector 844688 flags 8801
> > > [270581.167124] print_req_error: I/O error, dev nbd0, sector 5123248 flags 8801
> > > [270581.167590] block nbd0: Connection timed out
> > > [270581.167597] print_req_error: I/O error, dev nbd0, sector 844696 flags 8801
> > > [270581.168021] print_req_error: I/O error, dev nbd0, sector 5123256 flags 8801
> > > [270581.168487] block nbd0: Connection timed out
> > > [270581.168493] print_req_error: I/O error, dev nbd0, sector 844704 flags 8801
> > > [270581.170183] print_req_error: I/O error, dev nbd0, sector 5123264 flags 8801
> > > [270581.170540] block nbd0: Connection timed out
> > > [270581.173333] block nbd0: Connection timed out
> > > [270581.173728] block nbd0: Connection timed out
> > > [270581.174135] block nbd0: Connection timed out
> > >  
> > > On the other hand, if we wait nbd_xmit_timeout to handle resubmission,
> > > the I/O requests will have a big delay. For example, if timeout time is 30s,
> > > and from sock dead to nbd_genl_reconfigure returned OK we only spend
> > > 2s, the I/O requests will still be handled by nbd_xmit_timeout after 30s.
> > 
> > We have to wait for the full timeout anyway to know that the socket went down,
> > so it'll be re-submitted right away and then we'll wait on the new connection.
> > 
> > Now we could definitely have requests that were submitted well after the first
> > thing that failed, so their timeout would be longer than simply retrying them,
> > but we have no idea of knowing which ones timed out and which ones didn't.  This
> > way lies pain, because we have to matchup tags with handles.  This is why we
> > rely on the generic timeout infrastructure, so everything is handled correctly
> > without ending up with duplicate submissions/replies.  Thanks,
> > 
> > Josef
> > 
> 
> But as I mentioned before, if num_connections == 1, nbd_xmit_timeout won't re-submit
> commands and I/O error will occur. Should we change the condition
> 		if (config->num_connections > 1)
> to
> 		if (config->num_connections >= 1)
> ?

Only if you don't have the patch 3 in place though right?  If you fix patch 3 to
allow requeuing if you have a dead connection timer set then you can requeue and
everything is a-ok.  Thanks,

Josef
