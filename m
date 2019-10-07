Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB07CE8DD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 18:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfJGQPm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Oct 2019 12:15:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44929 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfJGQPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:15:42 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iHVff-0000Fj-A1; Mon, 07 Oct 2019 18:15:39 +0200
Date:   Mon, 7 Oct 2019 18:15:39 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Yongxin Liu <yongxin.liu@windriver.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, haitao.liu@windriver.com,
        zhe.he@windriver.com
Subject: Re: [PATCH RT] kmemleak: Change the lock of kmemleak_object to
 raw_spinlock_t
Message-ID: <20191007161539.5fi5wfc7kl3wdzct@linutronix.de>
References: <20190927082230.34152-1-yongxin.liu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190927082230.34152-1-yongxin.liu@windriver.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-27 16:22:30 [+0800], Yongxin Liu wrote:
> From: Liu Haitao <haitao.liu@windriver.com>
> 
> The following call trace would be triggered as kmemleak is running.
> 
…

Applied.

Sebastian
