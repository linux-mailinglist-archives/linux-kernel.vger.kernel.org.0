Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9917D226
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 02:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfHAAIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 20:08:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58380 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfHAAIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 20:08:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 262F0287EEF
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH RFC 1/2] futex: Split key setup from key queue locking and read
Organization: Collabora
References: <20190730220602.28781-1-krisman@collabora.com>
        <alpine.DEB.2.21.1908010131200.1788@nanos.tec.linutronix.de>
Date:   Wed, 31 Jul 2019 20:07:55 -0400
In-Reply-To: <alpine.DEB.2.21.1908010131200.1788@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Thu, 1 Aug 2019 01:33:25 +0200 (CEST)")
Message-ID: <85sgql7nok.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, 30 Jul 2019, Gabriel Krisman Bertazi wrote:
>
>> split the futex key setup from the queue locking and key reading.  This
>> is useful to support the setup of multiple keys at the same time, like
>> what is done in futex_requeue() and what will be done for the
>
> What has this to do with futex_requeue()? Absolutely nothing unleass you
> can reused that code there, which I doubt.

futex_requeue is another place where more than one key is setup at a
time.  Just that.  I think it could be reused there, but this change is
out of scope for this patch.

-- 
Gabriel Krisman Bertazi
