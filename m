Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC9B9C8CFE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 17:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfJBPhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 11:37:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36938 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbfJBPhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:37:24 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6549D336E9101D376BFE;
        Wed,  2 Oct 2019 23:37:13 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 2 Oct 2019
 23:37:07 +0800
From:   John Garry <john.garry@huawei.com>
Subject: perf tool pmuevents: About arm64 a76 JSON
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        <seanvk.dev@oregontracks.org>,
        Florian Fainelli <f.fainelli@gmail.com>, <wcohen@redhat.com>,
        Ganapatrao Kulkarni <gklkml16@gmail.com>,
        Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To:     <James.Clark@arm.com>
Message-ID: <749a0b8e-2bfd-28f6-b34d-dc72ef3d3a74@huawei.com>
Date:   Wed, 2 Oct 2019 16:37:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed that the JSON to support a76 pmu events was added recently.

May I ask why we add explicit support for the common architectural and 
microarch events (event id 0x0-0x3f), when they would be already 
available from the kernel pmuv3 driver?

The ampere emag jsons do similar. Others don't.

The only advantage I see is that we have an event description, but I am 
sure how useful that is.

Cheers,
John

