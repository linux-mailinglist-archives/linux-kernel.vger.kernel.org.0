Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52DC4298BA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 15:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391620AbfEXNRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 09:17:19 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44235 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391124AbfEXNRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:17:18 -0400
Received: by mail-vk1-f195.google.com with SMTP id j4so2099309vke.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 06:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uZ0Zg2uNirK9y14G1GGlkyl+JyTXOEhOPCDV27xwj8c=;
        b=KVMIGYPAnG8rCkGjZMc5w+BUKN3bsquzT+RjW3mWL8+At7Zi2zogqW+Xd6kiPBCctA
         4dE7ML06tMw3uJNZT/659ydbjB/R1C+JWBdxsVIePOWjQjgHP+hC8Z4+wzyCd79LMjAe
         5miSfzE55s6KgkstL7V/0JTa+LyCyKcWAnJ1WzdO1UDAN3QRFW962kdB8g1wKgrYNybV
         h8ntSwUZX+4EHuUhKd5AEuognCDKVtgGoj8PpC8zaLHwHTfCDN+A89Cy6uLItyZmywxk
         rlgfeNQUQcvoGGPU6j8LtoQZS8g2ylCMixTXz1PmCeK7z22xOjFCuEoQPwKad01b42hW
         ZPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uZ0Zg2uNirK9y14G1GGlkyl+JyTXOEhOPCDV27xwj8c=;
        b=HJRYzzRP/OqbplqxXdwnTokCdOtda1Zk0QWsiTjojxolQ4JJgt3hhHiIn6QTAQN4b1
         7T0MEEgdGo+CzWq4aMovnqCEygiIIY7FG+/FXkA2Zn60Lw1/exjz+xeXypf6Jrb+0G+a
         mp2uD3lZ3xRX4yHQxmQSInVSXCLUJaLQNnSdghJqvf6wmJYwyhcKsE5lO3EzpoNF5NiQ
         Gc3moAlVDG7fHPsyXjtqpmPCyGkz1mwbHPg5ceLj5PaHKS8H3YQu6gGBk0+aLGsOdomy
         1CMxGg2PEOnNdH3c74YY+71m/2mIi+/VY4boY7/l3Ag7hJ21D5DR6L+lMqWIV99PPbfe
         qajQ==
X-Gm-Message-State: APjAAAUZ2uY0g20vEDFjOlchBWGw7Dwimqr6HrAfyp9GVsuJ5JIYsWaD
        In2oRShYdgxe4MtypP9JJnx0Rw==
X-Google-Smtp-Source: APXvYqwbxvb1agF6wdEfvSucciNSzicTQUfXHMAfETxwg9x9k6nYAbdxRWEXFj3tTX26smk+8dleRQ==
X-Received: by 2002:a1f:3ad1:: with SMTP id h200mr4754507vka.24.1558703837630;
        Fri, 24 May 2019 06:17:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e914])
        by smtp.gmail.com with ESMTPSA id l31sm610274uae.15.2019.05.24.06.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 06:17:16 -0700 (PDT)
Date:   Fri, 24 May 2019 09:17:15 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yao Liu <yotta.liu@ucloud.cn>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] nbd: mark sock as dead even if it's the last one
Message-ID: <20190524131714.i3lbkbokad6xmotv@MacBook-Pro-91.local.dhcp.thefacebook.com>
References: <1558691036-16281-1-git-send-email-yotta.liu@ucloud.cn>
 <1558691036-16281-3-git-send-email-yotta.liu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558691036-16281-3-git-send-email-yotta.liu@ucloud.cn>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 05:43:56PM +0800, Yao Liu wrote:
> When sock dead, nbd_read_stat should return a ERR_PTR and then we should
> mark sock as dead and wait for a reconnection if the dead sock is the last
> one, because nbd_xmit_timeout won't resubmit while num_connections <= 1.

num_connections is the total number of connections that the device was set up
with, not how many are left.  Now since we have the dead_conn_timeout timeout
stuff now which didn't exist when I originally wrote this code I'd be ok with
doing that, but not the way you have it now.  It would be something more like

	if (nbd_disconnected(config) ||
	    (config->num_connections <= 1 &&
	     !config->dead_conn_timeout)

instead.  Thanks,

Josef
