Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40C6617E690
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 19:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgCISOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 14:14:24 -0400
Received: from foss.arm.com ([217.140.110.172]:55550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727399AbgCISOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:14:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E41071FB;
        Mon,  9 Mar 2020 11:14:23 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF3103F67D;
        Mon,  9 Mar 2020 11:14:22 -0700 (PDT)
Date:   Mon, 9 Mar 2020 18:14:20 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Torsten Duwe <duwe@lst.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH] arm64: efi: add efi-entry.o to targets instead of
 extra-$(CONFIG_EFI)
Message-ID: <20200309181420.GG4124965@arrakis.emea.arm.com>
References: <20200305052052.30757-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305052052.30757-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 02:20:52PM +0900, Masahiro Yamada wrote:
> efi-entry.o is built on demand for efi-entry.stub.o, so you do not have
> to repeat $(CONFIG_EFI) here. Adding it to 'targets' is enough.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Queued for 5.7. Thanks.

-- 
Catalin
