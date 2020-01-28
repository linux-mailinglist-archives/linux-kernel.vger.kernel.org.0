Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF6914BEF2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 18:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgA1Rwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 12:52:45 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34697 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1Rwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:52:44 -0500
Received: from ip5f5bd665.dynamic.kabel-deutschland.de ([95.91.214.101] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iwV2T-0001Qo-Pj; Tue, 28 Jan 2020 17:52:37 +0000
Date:   Tue, 28 Jan 2020 18:52:36 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     madhuparnabhowmik10@gmail.com
Cc:     oleg@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, joel@joelfernandes.org, frextrite@gmail.com,
        rcu@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] fork.c: Use RCU_INIT_POINTER() instead of
 rcu_access_pointer()
Message-ID: <20200128175236.vnaaviccbl2klrci@wittgenstein>
References: <20200127175821.10833-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200127175821.10833-1-madhuparnabhowmik10@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 11:28:21PM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> Use RCU_INIT_POINTER() instead of rcu_access_pointer() in
> copy_sighand().
> 
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Applied, queued up for post rc1.

Thanks!
Christian
