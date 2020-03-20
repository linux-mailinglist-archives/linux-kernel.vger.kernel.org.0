Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7F018D69C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 19:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgCTSMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 14:12:12 -0400
Received: from foss.arm.com ([217.140.110.172]:55230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCTSMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:12:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 982741FB;
        Fri, 20 Mar 2020 11:12:11 -0700 (PDT)
Received: from [10.37.12.158] (unknown [10.37.12.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72FA53F305;
        Fri, 20 Mar 2020 11:12:10 -0700 (PDT)
Subject: Re: [PATCH 4/6] arm64/cpufeature: Define an explicit ftr_id_isar0[]
 for ID_ISAR0 register
To:     anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org
References: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
 <1580215149-21492-5-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <54de9128-c947-4f68-7646-4261adde7f36@arm.com>
Date:   Fri, 20 Mar 2020 18:16:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1580215149-21492-5-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28/2020 12:39 PM, Anshuman Khandual wrote:
> ID_ISAR0[31..28] bits are RES0 in ARMv8, Reserved/UNK in ARMv7. Currently
> these bits get exposed through generic_id_ftr32[] which is not desirable.
> Hence define an explicit ftr_id_isar0[] array for ID_ISAR0 register where
> those bits can be hidden.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
