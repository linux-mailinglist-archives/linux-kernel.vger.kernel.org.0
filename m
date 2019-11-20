Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2752910325A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 04:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfKTD4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 22:56:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfKTD4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 22:56:03 -0500
Received: from [192.168.1.20] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61F292245C;
        Wed, 20 Nov 2019 03:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574222162;
        bh=mErPzJyApCBLMGjkqaZyHq//nd2I7b04MuuBEmA7Cbk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OxK7gV6sDf8lNL1X17IYkTKlQ0uTSLTJpzsMNgUY7fqCnE9avYp7YJGyrbXbYKT4M
         iROTEII5q/iUAE0Of1c6AcMZayfJ/oHKxnb8cpgJRA9AoVYyNU7FOQFrWdrl01/85L
         TYh1p25R327CCBx1kJtFwKSeMOQDFewUmtJXg6zM=
Subject: Re: [PATCH v5 00/48] QUICC Engine support on ARM, ARM64, PPC64
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <5a44ea0e-1c56-1062-37a9-376f4b6ac6f0@kernel.org>
Date:   Tue, 19 Nov 2019 21:55:59 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/19 5:22 AM, Rasmus Villemoes wrote:
> There have been several attempts in the past few years to allow
> building the QUICC engine drivers for platforms other than PPC32. This
> is yet another attempt.
> 
> v4 can be found here: https://lore.kernel.org/lkml/20191108130123.6839-1-linux@rasmusvillemoes.dk/

This is excellent work, thank you.

All patches:

Reviewed-by: Timur Tabi <timur@kernel.org>

Serial patches:

Acked-by: Timur Tabi <timur@kernel.org>
