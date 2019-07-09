Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE0D6339D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 11:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfGIJnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 05:43:02 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:40294 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfGIJnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 05:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=zDqbZz+4vdtztSUqfBA7a3vsGDNvhgQkVugt/N61WMU=;
        b=nR4wmDhw2suZ++2I7+DukSELP6uxXS7S6lKw9OOwmrct0LSOUFldrHyyvOgkU097e22rPTQ9E0XzJcMv3pELcq7DUU+JYDsSfny6sLwBfJe30Y68kNLdwknz+NTpz/xEkCYWEWIjQ3c6oDBsG8aziyRYnhP4CEcelQb5nxGJl2wvhjoYU1KrHHNnCRiFHBskm1u5NGQ8pSCIM2n6/2YmDaDOGEj1Xab2/F8ea8fEyJtgMKF1xUMtmdNw6FAOrKj6ql+sFXSewLdygyaUBFgjnayHOlRS+3I6csDe3313EoV+g9jZwdkcEC86QeE4rBtuK4W2erD9EQW1ZlUQDbMUaA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:64759 helo=[192.168.10.173])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hkmeJ-00038q-Os; Tue, 09 Jul 2019 11:42:59 +0200
Subject: Re: [PATCH] drm/client: remove the exporting of drm_client_close
To:     Emil Velikov <emil.l.velikov@gmail.com>,
        Denis Efremov <efremov@linux.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20190703170150.32548-1-efremov@linux.com>
 <CACvgo52N5v07qA_afJfw7vo1X6_Gt4cGqBZn3eBzQtokndjWxA@mail.gmail.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <9590074a-dbc4-24d3-4f93-51d942981860@tronnes.org>
Date:   Tue, 9 Jul 2019 11:42:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACvgo52N5v07qA_afJfw7vo1X6_Gt4cGqBZn3eBzQtokndjWxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 04.07.2019 16.07, skrev Emil Velikov:
> On Thu, 4 Jul 2019 at 08:27, Denis Efremov <efremov@linux.com> wrote:
>>
>> The function drm_client_close is declared as static and marked as
>> EXPORT_SYMBOL. It's a bit confusing for an internal function to be
>> exported. The area of visibility for such function is its .c file
>> and all other modules. Other *.c files of the same module can't use it,
>> despite all other modules can. Relying on the fact that this is the
>> internal function and it's not a crucial part of the API, the patch
>> removes the EXPORT_SYMBOL marking of drm_client_close.
>>
>> Signed-off-by: Denis Efremov <efremov@linux.com>
> 
> Nice one:
> Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

Thanks, applied.

Noralf.
