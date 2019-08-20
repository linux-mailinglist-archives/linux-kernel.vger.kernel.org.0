Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F77995972
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 10:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfHTI2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 04:28:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51067 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfHTI2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:28:14 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hzzUw-0006no-Bm; Tue, 20 Aug 2019 10:28:10 +0200
Date:   Tue, 20 Aug 2019 10:28:10 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        williams@redhat.com
Subject: Re: [RT PATCH v2] net/xfrm/xfrm_ipcomp: Protect scratch buffer with
 local_lock
Message-ID: <20190820082810.ixkmi56fp7u7eyn2@linutronix.de>
References: <20190819122731.6600-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190819122731.6600-1-juri.lelli@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-19 14:27:31 [+0200], Juri Lelli wrote:
> This v2 applies to v4.19.59-rt24.

Looks good, I suggest to apply this to v4.19 and earlier.

For v5.2 and later (including upstream) please send a patch to simply
replace get_cpu() with smp_processor_id(). The reason is that get_cpu()
will not disable BH and according to the call path this function is
invoked in NAPI callback and the other sides does local_bh_disable().
Therefore the caller of this must ensure that BH is disabled and
disabling preemption is not enough.

Sebastian
