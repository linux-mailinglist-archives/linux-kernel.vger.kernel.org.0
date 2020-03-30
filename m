Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA0F1976D8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 10:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgC3Ioj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 04:44:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50909 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgC3Ioi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:44:38 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jIq1o-0004PU-Hp; Mon, 30 Mar 2020 08:44:16 +0000
Date:   Mon, 30 Mar 2020 10:44:15 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     ebiederm@xmission.com, oleg@redhat.com, tj@kernel.org, guro@fb.com,
        joel@joelfernandes.org, jannh@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>,
        Yanxiaodan <yanxiaodan@huawei.com>,
        linfeilong <linfeilong@huawei.com>
Subject: Re: [PATCH] signal: check sig before setting info in
 kill_pid_usb_asyncio
Message-ID: <20200330084415.p4v5g6s24innsjrc@wittgenstein>
References: <f525fd08-1cf7-fb09-d20c-4359145eb940@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f525fd08-1cf7-fb09-d20c-4359145eb940@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 10:18:33AM +0800, Zhiqiang Liu wrote:
> 
> In kill_pid_usb_asyncio, if signal is not valid, we do not need to
> set info struct.
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>

I'd have done:

if (!valid_signal(sig))
	return -EINVAL;

instead of setting ret to EINVAL above but that's mostly a matter of style.

Picking this up unless someone sees a problem with it.

Thank you!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
