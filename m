Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A166410CE54
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 19:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfK1SHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 13:07:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46988 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfK1SHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 13:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ks8gIs9oYy0E3eRemhcOFX7mAIK90vuzz1FlyLwPqag=; b=fjhG8FjOqdyQHSa9hPWjeDVyA
        Zeg48m99YaRd2bFDMjTHO1bpV/j3+qZg8qECwyepjAk8n9yNx4MHUNCiq+CCgO0edAZgfiJGdJVEu
        fykBepsXlZPJPoh6BC/183fFbpNezcMhmYpulKNHrI5nOF2hHbeI9hhfzILMCcpX/fovjvwzHoq/J
        ExaQmLrlBhBjihelP3F4/iG9bOHq7mpZt4I0QmXUZGjuks2gIbc6clUoMpZfC7o/0DQbE1GBz64X+
        PYf63VE9ZzJSHkKKrCwjUJVgT4bNXLTvUw4wIkJAF78jgUbdq7FMfwUHNAKH01mBf5p52CFjGKbFc
        6lDyiunpQ==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iaOCl-0005Kn-Lh; Thu, 28 Nov 2019 18:07:51 +0000
Subject: Re: [PATCH] moduleparam: fix kerneldoc
To:     Fabien Dessenne <fabien.dessenne@st.com>,
        Jessica Yu <jeyu@kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        linux-kernel@vger.kernel.org
References: <1574960280-28770-1-git-send-email-fabien.dessenne@st.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bc38fbde-fa80-43f2-abf2-6629c346d8e3@infradead.org>
Date:   Thu, 28 Nov 2019 10:07:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1574960280-28770-1-git-send-email-fabien.dessenne@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/19 8:58 AM, Fabien Dessenne wrote:
> Document missing @args in xxx_param_cb().
> Typo: use 'value' instead of 'lvalue'.

I think that it's not a typo...

Wikipedia says for lvalue:
In computer science, a value that points to a storage location, potentially allowing new values to be assigned (so named because it appears on the left side of a variable assignment)


> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  include/linux/moduleparam.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index e5c3e23..944c569 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -135,7 +135,7 @@ struct kparam_array
>  /**
>   * module_param_named - typesafe helper for a renamed module/cmdline parameter
>   * @name: a valid C identifier which is the parameter name.
> - * @value: the actual lvalue to alter.
> + * @value: the actual value to alter.
>   * @type: the type of the parameter
>   * @perm: visibility in sysfs.
>   *
> @@ -160,6 +160,7 @@ struct kparam_array
>   * module_param_cb - general callback for a module/cmdline parameter
>   * @name: a valid C identifier which is the parameter name.
>   * @ops: the set & get operations for this parameter.
> + * @args: args for @ops
>   * @perm: visibility in sysfs.
>   *
>   * The ops can have NULL set or get functions.
> @@ -176,6 +177,7 @@ struct kparam_array
>   *                    to be evaluated before certain initcall level
>   * @name: a valid C identifier which is the parameter name.
>   * @ops: the set & get operations for this parameter.
> + * @args: args for @ops
>   * @perm: visibility in sysfs.
>   *
>   * The ops can have NULL set or get functions.
> @@ -457,7 +459,7 @@ enum hwparam_type {
>  /**
>   * module_param_hw_named - A parameter representing a hw parameters
>   * @name: a valid C identifier which is the parameter name.
> - * @value: the actual lvalue to alter.
> + * @value: the actual value to alter.
>   * @type: the type of the parameter
>   * @hwtype: what the value represents (enum hwparam_type)
>   * @perm: visibility in sysfs.
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
