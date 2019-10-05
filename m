Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16BABCC8EE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 11:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfJEJDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 05:03:17 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:59411 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfJEJDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 05:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds201810; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=p2ZvjAtFLmmRhheK0QBBgB4Z3DITrok9mnQpQe4ZL8k=; b=gwU4gKCNPpsjADrV7KzCt8x2Hv
        JRWWN0e9e5im8fsEFMrW+GoUNL6QJpPQC9DOGndiqM321xSylWMjBUBsrJpucexYKedkLJFjD+Zv6
        ygvdSMz98xovf9scLmn+SgkBp+MzntNhbyS75KaNQPuEUcJeQji/hk/FmE+/AG1GRqcJ44TbOxlqH
        6Xoy8cvvN3LGlIlHVBtDS6VNWnuFVrjy34obWxQ+wdVQgdyCXQ9F3tRGkiCRMoX7LhkTBc4DCQl/R
        Tj+Yh5E1OdrploBf08PHKfi0k0HjU7RimgXZkmT3H15O4SyQOPwFoDj6NpiywBA11laNyJUeHO2H2
        ChoHDG3Q==;
Received: from [2a01:79c:cebe:b88c:caff:28ff:fe94:90a0] (port=55588)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1iGfy6-0002Li-7a; Sat, 05 Oct 2019 11:03:14 +0200
Subject: Re: BISECTED: Compile error on 5.4-rc1
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cf947abb-c94e-9b6f-229a-1e219fd38e94@skogtun.org>
 <CAK7LNAS-msvdv+=msqfSYX3ZKPQm_AJ0B=Uu7hfah1V+NGPjmQ@mail.gmail.com>
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <240d0353-2e66-7d0c-3dc0-f58f62c999be@skogtun.org>
Date:   Sat, 5 Oct 2019 11:03:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAS-msvdv+=msqfSYX3ZKPQm_AJ0B=Uu7hfah1V+NGPjmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: nb-NO
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada [05.10.2019 05:24]:

> I cannot reproduce it.
> 
> I tested bindeb-pkg for the latest Linus tree successfully.

Strange, I have now tried another machine running the same distro
(Devuan Beowulf), and I get the same result there. Will check further.
-- 
Hilsen Harald
