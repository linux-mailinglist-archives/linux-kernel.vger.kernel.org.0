Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1711CE768C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 17:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391100AbfJ1QhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 12:37:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:43482 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729420AbfJ1QhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:37:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8042CAD08;
        Mon, 28 Oct 2019 16:37:02 +0000 (UTC)
Date:   Mon, 28 Oct 2019 09:35:37 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     eric@anholt.net, wahrenst@gmx.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vc04_services: replace g_free_fragments_mutex
 with spinlock
Message-ID: <20191028163537.b2pspgdl6ceevcxv@linux-p48b>
References: <20191027221530.12080-1-dave@stgolabs.net>
 <20191028155354.s3bgq2wazwlh32km@linux-p48b>
 <20191028162412.GA321492@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191028162412.GA321492@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019, Greg KH wrote:
>This is obviously not in a format I can apply it in :(

What are you talking about? I sent you the original patch,
then Cc'ed the drivers mailing list. So you still have a
patch you can apply... this is quite a common way of doing
things (Ccing for future references to someone or another
ml). I don't understand why you are hairsplitting over this
patch.

Thanks,
Davidlohr
