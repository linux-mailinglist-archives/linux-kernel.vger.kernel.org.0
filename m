Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97A62144117
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 16:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgAUP6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 10:58:54 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:34961 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbgAUP6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:58:54 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 9485E3C04C1;
        Tue, 21 Jan 2020 16:58:52 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nrM6_Rn9nnvl; Tue, 21 Jan 2020 16:58:47 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 760973C00C5;
        Tue, 21 Jan 2020 16:58:47 +0100 (CET)
Received: from lxhi-065.adit-jv.com (10.72.93.66) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 21 Jan
 2020 16:58:47 +0100
Date:   Tue, 21 Jan 2020 16:58:44 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH] arm64: kbuild: remove compressed images on 'make
 ARCH=arm64 (dist)clean'
Message-ID: <20200121155844.GA1284@lxhi-065.adit-jv.com>
References: <20200121134739.22879-1-erosca@de.adit-jv.com>
 <CAK7LNASm=7P3cJ=SB3hmPjqWTii1Lv2pf3p0xc-hx0XNTdaJHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAK7LNASm=7P3cJ=SB3hmPjqWTii1Lv2pf3p0xc-hx0XNTdaJHw@mail.gmail.com>
X-Originating-IP: [10.72.93.66]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yamada-san,

On Wed, Jan 22, 2020 at 12:23:45AM +0900, Masahiro Yamada wrote:
> Please change Cc with my
> 
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Updated in https://lore.kernel.org/linux-arm-kernel/20200121155439.1061-1-erosca@de.adit-jv.com/

Thank you for reviewing the patch.

-- 
Best Regards
Eugeniu Rosca
