Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 250DA505B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 11:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfFXJaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 05:30:20 -0400
Received: from thoth.sbs.de ([192.35.17.2]:51847 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbfFXJaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:30:19 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id x5O9TxZj023904
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 11:29:59 +0200
Received: from [167.87.13.35] ([167.87.13.35])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x5O9Tvbl015092;
        Mon, 24 Jun 2019 11:29:57 +0200
Subject: Re: PREEMPT_RT_FULL on x86-32 machine
To:     Pavel Machek <pavel@ucw.cz>, linux-rt-users@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Cc:     mwhitehe@redhat.com
References: <20190622081954.GA10751@amd>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2804bc5b-18c1-2793-171c-045c0725a6a7@siemens.com>
Date:   Mon, 24 Jun 2019 11:29:56 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <20190622081954.GA10751@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.19 10:19, Pavel Machek wrote:
> Hi!
> 
> Is full preemption supposed to work on x86-32 machines?
> 
> Because it does not work for me. It crashes early in boot, no messages
> make it to console. Similar configuration for x86-64 boots ok.
> 

Maybe you can also tell which version(s) you tried, and in which 
configuration(s), and how the crash looked like.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
