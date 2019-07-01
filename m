Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C94842E091
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfE2PJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 11:09:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47684 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfE2PJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:09:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C65A341;
        Wed, 29 May 2019 08:09:13 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 342A03F5AF;
        Wed, 29 May 2019 08:09:12 -0700 (PDT)
Date:   Wed, 29 May 2019 16:09:09 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] fix function type mismatches in syscall wrappers
Message-ID: <20190529150909.GE11154@fuggles.cambridge.arm.com>
References: <20190524221118.177548-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524221118.177548-1-samitolvanen@google.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 03:11:15PM -0700, Sami Tolvanen wrote:
> These patches fix type mismatches in arm64 syscall wrapper
> definitions, which trip indirect call checks with Control-Flow
> Integrity.
> 
> Changes in v3:
> - instead of SYSCALL_DEFINE0, just define __arm64_sys_ni_syscall
>   with the correct type to avoid unnecessary error injection

Thanks, I've picked this up for -rc3.

Will
