Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB7EB11A58B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 09:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfLKIEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 03:04:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfLKIEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 03:04:36 -0500
Received: from [10.228.163.158] (unknown [2.55.135.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D38B2173E;
        Wed, 11 Dec 2019 08:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576051476;
        bh=B1Z2ZdmadE/uwSr7tP3e+eWCAuxvdqiIy995PRO7DnQ=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=sdVbIBaYyIIc8OK1sQiHd65Y9ChIPY3/OpofxyRTEaxO/bPYp8FqUdiVrguQFQFC3
         kMRQ6zy6hAkcv/CJWicRC5ceOpDPU40tYN+3gohr0toChexW0teHTP/NhAegW7Vzb2
         seiDATUX+pMqRUC4qD7OxXY32t/dTiZ2Hyn/GAMg=
Date:   Wed, 11 Dec 2019 10:04:29 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20191210.232556.198185739663319799.davem@davemloft.net>
References: <20191124085720.6201-1-rppt@kernel.org> <20191211062649.GA28255@rapoport-lnx> <20191210.232556.198185739663319799.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] sparc64: add support for folded p4d page tables
To:     David Miller <davem@davemloft.net>
CC:     sparclinux@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com
From:   Mike Rapoport <rppt@kernel.org>
Message-ID: <4C87F045-7902-415E-BE54-9F527CE3B5E6@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 11, 2019 9:25:56 AM GMT+02:00, David Miller <davem@davemloft=2E=
net> wrote:
>From: Mike Rapoport <rppt@kernel=2Eorg>
>Date: Wed, 11 Dec 2019 08:26:51 +0200
>
>> Any updates on this?
>
>I thought I gave my ack, sorry:
>
>Acked-by: David S=2E Miller <davem@davemloft=2Enet>

Can you please take it via sparc tree?

--=20
Sincerely yours,
Mike
