Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4059CDE0F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 11:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfJGJNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 05:13:25 -0400
Received: from foss.arm.com ([217.140.110.172]:58160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbfJGJNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 05:13:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9531C1570;
        Mon,  7 Oct 2019 02:13:24 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F5653F68E;
        Mon,  7 Oct 2019 02:13:24 -0700 (PDT)
Subject: Re: Question about sched_prio_to_weight values
To:     Francesco Poli <invernomuto@paranoici.org>,
        linux-kernel@vger.kernel.org
References: <20191007003205.8888ac99da2dd732b6198387@paranoici.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <506d5ee6-246a-a03d-ea11-227ff4de1467@arm.com>
Date:   Mon, 7 Oct 2019 10:13:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007003205.8888ac99da2dd732b6198387@paranoici.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francesco,

On 06/10/2019 23:32, Francesco Poli wrote:
[...]
> I searched the web and the mailing list archives, but I failed to find
> an answer to this question. Could someone please explain me how those
> numbers were picked?
> 

Following the blame rabbit hole I found this:

254753dc321e ("sched: make the multiplication table more accurate")
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=254753dc321ea2b753ca9bc58ac329557a20efac

which sounds like it would explain some small deltas if compared to a 
formula that is set in stone.

Hope that helps.

> Thanks for your time!
> 
> 
