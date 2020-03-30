Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB8C1976F2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 10:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgC3ItC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 04:49:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51070 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgC3ItC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:49:02 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jIq6A-0004sb-Ks; Mon, 30 Mar 2020 08:48:46 +0000
Date:   Mon, 30 Mar 2020 10:48:45 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     ebiederm@xmission.com, oleg@redhat.com, tj@kernel.org,
        akpm@linux-foundation.org, guro@fb.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, Mingfangsen <mingfangsen@huawei.com>,
        linfeilong <linfeilong@huawei.com>
Subject: Re: [PATCH] signal: use kill_proc_info instead of kill_pid_info in
 kill_something_info
Message-ID: <20200330084845.o5jdrg44pm3uiydh@wittgenstein>
References: <80236965-f0b5-c888-95ff-855bdec75bb3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80236965-f0b5-c888-95ff-855bdec75bb3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 10:44:43AM +0800, Zhiqiang Liu wrote:
> 
> signal.c provides kill_proc_info, we can use it instead of kill_pid_info
> in kill_something_info func gracefully.
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>

Thanks! I'll shorten the commit message header a little when picking
this up otherwise:

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
