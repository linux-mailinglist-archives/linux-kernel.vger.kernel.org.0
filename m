Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB9974322
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 04:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388975AbfGYCOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 22:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387963AbfGYCOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 22:14:50 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 659F721901;
        Thu, 25 Jul 2019 02:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564020889;
        bh=t6YV1jRiU5k7dKdj12HoNkBQZFF+ujCZGvPs5/A42Kk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aX2XtK6gB5ejEaBxLqVyJ/TOAcz9MXpO4wFHvJK27BI7nMJ66bC4KQWWx+4KmCJnf
         2sfsdssVncyUqYoMZJ/87+BQWYinKi9shQRbhox6E6HbGjOKMzrhqJuCaSeEixWfyO
         RX+oFOUvxyYHcMi37HkUlskgk2Y07nvAHQdB7lRU=
Date:   Wed, 24 Jul 2019 19:14:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     <gorcunov@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sys_prctl(): remove unsigned comparision with less
 than zero
Message-Id: <20190724191448.4db70a34f8b89bd8bdc085f5@linux-foundation.org>
In-Reply-To: <1563934308-20833-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190723094809.GE4832@uranus.lan>
        <1563934308-20833-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2019 10:11:48 +0800 Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:

> Currently, when calling prctl(PR_SET_TIMERSLACK, arg2), arg2 is an
> unsigned long value, arg2 will never < 0. Negative judgment is
> meaningless, so remove it.
> 
> ...
>
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2372,7 +2372,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  			error = current->timer_slack_ns;
>  		break;
>  	case PR_SET_TIMERSLACK:
> -		if (arg2 <= 0)
> +		if (arg2 == 0)
>  			current->timer_slack_ns =
>  					current->default_timer_slack_ns;

A number of years ago Linus expressed approval of such comparisons with
unsigned quantities.  He felt that it improves readability a little -
the reader doesn't have to scroll back and check the type.


