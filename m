Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D55CA3694F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 03:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfFFBfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 21:35:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18088 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726581AbfFFBfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 21:35:10 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 16A7F8394FA83C5D5F22;
        Thu,  6 Jun 2019 09:35:08 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 6 Jun 2019
 09:34:59 +0800
Subject: Re: [PATCH] scsi: libsas, lldds: Use dev_is_expander()
To:     John Garry <john.garry@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <intel-linux-scu@intel.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@profitbricks.com>,
        <lindar_liu@usish.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.de>
References: <1559751143-168560-1-git-send-email-john.garry@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <e8ad370e-6528-2ab1-5001-ab3fa4dc5ae8@huawei.com>
Date:   Thu, 6 Jun 2019 09:34:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1559751143-168560-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/6/6 0:12, John Garry wrote:
> Many times in libsas, and in LLDDs which use libsas, the check for an
> expander device is re-implemented or open coded.
> 
> Use dev_is_expander() instead. We rename this from
> sas_dev_type_is_expander() to not spill so many lines in referencing.
> 
> Signed-off-by: John Garry<john.garry@huawei.com>

Cannot agree more，

Reviewed-by: Jason Yan <yanaijie@huawei.com>

