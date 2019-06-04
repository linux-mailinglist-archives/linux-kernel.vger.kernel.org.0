Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A84634CEF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 18:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfFDQLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 12:11:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:16001 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbfFDQLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:11:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 09:11:42 -0700
X-ExtLoop1: 1
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by orsmga007.jf.intel.com with ESMTP; 04 Jun 2019 09:11:41 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [RFC PATCH 49/57] drivers: mfd: altera: Use
 driver_find_device_by_of_node() helper
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        Lee Jones <lee.jones@linaro.org>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-50-git-send-email-suzuki.poulose@arm.com>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <7d7e2a77-a7c9-fe62-5432-0e730e548bbb@linux.intel.com>
Date:   Tue, 4 Jun 2019 11:13:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559577023-558-50-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/19 10:50 AM, Suzuki K Poulose wrote:
> Use the new helper to find device by of_node.
> 
> Cc: Thor Thayer <thor.thayer@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
