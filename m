Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA0FD704B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 09:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfJOHjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 03:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbfJOHjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:39:48 -0400
Received: from [172.20.185.47] (93-45-246-98.ip104.fastwebnet.it [93.45.246.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50AF42086A;
        Tue, 15 Oct 2019 07:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571125187;
        bh=Aiq4w1ejH9LHSG6B6V0s1DON3wVfA/z9L1lQfdXmY+I=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=M+GjnbMhe3yGCa2sT26UJ4R6+UiE1G1OcWOxUrS3VbGz7fd6M/ribalKGa4ZYg2Bp
         CmAadnUHywHRphF8K0v8pYPzp9pXbUqLqaGV1hBHHG9WgirUpSqwt3l76qG2WENg3n
         5Ws8QKMNXmGpjnE7ETjOqWad+sTfiwJBBqocy8CI=
Date:   Tue, 15 Oct 2019 09:39:41 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20191015004659.l5xbxv4mlpzqpsdl@willie-the-truck>
References: <1569657746-31672-1-git-send-email-rppt@kernel.org> <20191015004659.l5xbxv4mlpzqpsdl@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] arm64: use generic free_initrd_mem()
To:     Will Deacon <will@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
From:   Mike Rapoport <rppt@kernel.org>
Message-ID: <2AB94CD5-3374-4A15-9422-689EE2549FC6@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 15, 2019 2:46:59 AM GMT+02:00, Will Deacon <will@kernel=2Eorg> w=
rote:
>On Sat, Sep 28, 2019 at 11:02:26AM +0300, Mike Rapoport wrote:
>> From: Mike Rapoport <rppt@linux=2Eibm=2Ecom>
>>=20
>> arm64 calls memblock_free() for the initrd area in its implementation
>of
>> free_initrd_mem(), but this call has no actual effect that late in
>the boot
>> process=2E By the time initrd is freed, all the reserved memory is
>managed by
>> the page allocator and the memblock=2Ereserved is unused, so the only
>purpose
>> of the memblock_free() call is to keep track of initrd memory for
>debugging
>> and accounting=2E
>>=20
>> Without the memblock_free() call the only difference between arm64
>and the
>> generic versions of free_initrd_mem() is the memory poisoning=2E
>>=20
>> Move memblock_free() call to the generic code, enable it there
>> for the architectures that define ARCH_KEEP_MEMBLOCK and use the
>generic
>> implementation of free_initrd_mem() on arm64=2E
>>=20
>> Signed-off-by: Mike Rapoport <rppt@linux=2Eibm=2Ecom>
>> ---
>>=20
>> v4:
>> * memblock_free() aligned area around the initrd
>
>Looks straightforward to me:
>
>Acked-by: Will Deacon <will@kernel=2Eorg>

 Can it go via arm64 tree?

>Will


--=20
Sincerely yours,
Mike
