Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A06374B4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 14:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfFFM7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 08:59:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47032 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfFFM7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:59:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA5C6374;
        Thu,  6 Jun 2019 05:59:52 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCAA53F5AF;
        Thu,  6 Jun 2019 05:59:51 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] coresight: tmc-etr: Do not call smp_processor_id()
 from preemptible
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, robin.murphy@arm.com
References: <1559235267-25232-1-git-send-email-suzuki.poulose@arm.com>
 <1559235267-25232-2-git-send-email-suzuki.poulose@arm.com>
 <20190603192902.GB20462@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c4b3ff16-904b-1755-b622-33b2d38bcedf@arm.com>
Date:   Thu, 6 Jun 2019 13:59:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603192902.GB20462@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/06/2019 20:29, Mathieu Poirier wrote:
> On Thu, May 30, 2019 at 05:54:24PM +0100, Suzuki K Poulose wrote:
>> Instead of using smp_processor_id() to figure out the node,
>> use the numa_node_id() for the current CPU node to avoid
>> splats like :
> 
> I was in the process of applying this set when I noticed the changelogs are
> still referring to numa_node_id(), which is not part of the solution anymore.
> Please address in all 4 patches.
> 

Sorry about the last minute messup. I will resend it.

Cheers
Suzuki
