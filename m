Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA1F7D1F2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 01:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbfGaXdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 19:33:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33402 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfGaXdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 19:33:31 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hsy62-00016P-8Q; Thu, 01 Aug 2019 01:33:26 +0200
Date:   Thu, 1 Aug 2019 01:33:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
cc:     mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH RFC 1/2] futex: Split key setup from key queue locking
 and read
In-Reply-To: <20190730220602.28781-1-krisman@collabora.com>
Message-ID: <alpine.DEB.2.21.1908010131200.1788@nanos.tec.linutronix.de>
References: <20190730220602.28781-1-krisman@collabora.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019, Gabriel Krisman Bertazi wrote:

> split the futex key setup from the queue locking and key reading.  This
> is useful to support the setup of multiple keys at the same time, like
> what is done in futex_requeue() and what will be done for the

What has this to do with futex_requeue()? Absolutely nothing unleass you
can reused that code there, which I doubt.

Thanks,

	tglx
