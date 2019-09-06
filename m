Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8550ABC0A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 17:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390242AbfIFPRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 11:17:31 -0400
Received: from foss.arm.com ([217.140.110.172]:57890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfIFPRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:17:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C4CC1576;
        Fri,  6 Sep 2019 08:17:30 -0700 (PDT)
Received: from [10.1.196.105] (unknown [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F5F13F59C;
        Fri,  6 Sep 2019 08:17:27 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH v3 02/17] arm64, hibernate: use get_safe_page directly
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-3-pasha.tatashin@soleen.com>
Message-ID: <dc6506a0-9b66-f633-8319-9c8a9dc93d4f@arm.com>
Date:   Fri, 6 Sep 2019 16:17:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190821183204.23576-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Nit: The pattern for the subject prefix should be "arm64: hibernate:"..
Its usually possible to spot the pattern from "git log --oneline $file".

On 21/08/2019 19:31, Pavel Tatashin wrote:
> create_safe_exec_page is a local function that uses the
> get_safe_page() to allocate page table and pages and one pages
> that is getting mapped.

I can't parse this.

create_safe_exec_page() uses hibernate's allocator to create a set of page table to map a
single page that will contain the relocation code.


> Remove the allocator related arguments, and use get_safe_page
> directly, as it is done in other local functions in this
> file.
... because kexec can't use this as it doesn't have a working allocator.
Removing this function pointer makes it easier to refactor the code later.

(this thing is only a function pointer so kexec could use it too ... It looks like you're
creating extra work. Patch 7 moves these new calls out to a new file... presumably so
another patch can remove them again)

As stand-alone cleanup the patch looks fine, but you probably don't need to do this.


Thanks,

James
