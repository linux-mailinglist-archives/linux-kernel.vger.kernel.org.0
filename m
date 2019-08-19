Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF9091E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 09:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfHSH7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 03:59:36 -0400
Received: from foss.arm.com ([217.140.110.172]:50428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfHSH7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:59:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7E76337;
        Mon, 19 Aug 2019 00:59:35 -0700 (PDT)
Received: from [10.1.196.120] (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7250E3F718;
        Mon, 19 Aug 2019 00:59:34 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] arm64: perf: Enable pmu counter direct access for
 perf event on armv8
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        acme@kernel.org, mark.rutland@arm.com, raph.gault+kdev@gmail.com
References: <20190816125934.18509-5-raphael.gault@arm.com>
 <201908182002.KAH4UW2w%lkp@intel.com>
From:   Raphael Gault <raphael.gault@arm.com>
Message-ID: <a41e1a4b-b082-725a-b24e-9c92f66d174a@arm.com>
Date:   Mon, 19 Aug 2019 08:59:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201908182002.KAH4UW2w%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/18/19 1:37 PM, kbuild test robot wrote:
> Hi Raphael,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc4 next-20190816]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

This patchset was based on linux-next/master and note linus

Thanks,

-- 
Raphael Gault
