Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C4118AD3E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 08:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgCSHSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 03:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgCSHSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 03:18:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4DCB20409;
        Thu, 19 Mar 2020 07:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584602310;
        bh=njT/OnNfe0hqlk7i4Z67Q/AZfyprWBxsfE/qvmU7tm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bAG0T4JhI9Z9toM0BU4pyf8HXrA0RYlHwrQ5z3Q0W7rz/+yqwU3qoMxPh4N1OMs2t
         Kc/PUxGfDdfKKuwFKlA/lR/IK/ZZS5QRRB1T23iPQ9uevZAalDAU/ADbIU0QVwvTDy
         pOpJRZkIFRZV/+remq1Ntwi1hM09T8TwdsWEZXwg=
Date:   Thu, 19 Mar 2020 08:18:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "suqiang (C)" <suqiang4@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liyou (leeyou, RTOS)" <leeyou.li@huawei.com>
Subject: Re: [PATCH V2] UIO: make maximum memory and port regions configurable
Message-ID: <20200319071827.GA3365217@kroah.com>
References: <20200307081008.26848-1-suqiang4@huawei.com>
 <20200318113352.GA2365557@kroah.com>
 <7AF579E0012A4E4FA1B0EC683F4B7F591F96D204@dggeml525-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7AF579E0012A4E4FA1B0EC683F4B7F591F96D204@dggeml525-mbx.china.huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

http://daringfireball.net/2007/07/on_top

On Thu, Mar 19, 2020 at 03:11:20AM +0000, suqiang (C) wrote:
> Dear Greg,
> Thanks a lot for suggestion. I will add more information in these help texts and send PATCH V3 soon.
> Furthermore, of cause it is better to make these values dynamic and grow as needed by the system. A possible way is to manage memory and port resource by a dynamic list instead of a static array.
> But it costs more time to design and implement a better scheme. I will try it later and push patchs when it's finished.
> This patch is a temporary way better than nothing, and I hope it could be accept.

No, please do it correctly, there is no rush here.  Moving from an array
to a list should not be that difficult.

thanks,

greg k-h
