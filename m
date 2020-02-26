Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A391B16F9BC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 09:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgBZIjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 03:39:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbgBZIjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:39:43 -0500
Received: from localhost (unknown [171.76.87.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78786222C2;
        Wed, 26 Feb 2020 08:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582706383;
        bh=LYIUguxIL6wJHCQWIRNDa0HHgxSUcSnBZ4MGaN9UEBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mJqtwb1loYlCJ/FFQM9s1OHOUON3w4iePK73PkG8hhxlGfBeBVO4KHAlYOMnluSX+
         MjY+7kC6/tHP4Qpz6GKOUMBjdWOoyMl3GSAgdl9UsvYLVnHWDRyKNzYV3aVI3L0Ru2
         roTF4i1OHNCm5WlL2ws67tgrg/Jv63Q3eH8WQH1k=
Date:   Wed, 26 Feb 2020 14:09:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 3/3] soundwire: add helper macros for devID fields
Message-ID: <20200226083939.GX2618@vkoul-mobl>
References: <20200225170041.23644-1-pierre-louis.bossart@linux.intel.com>
 <20200225170041.23644-4-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225170041.23644-4-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-02-20, 11:00, Pierre-Louis Bossart wrote:
> Move bit extractors to macros, so that the definitions can be used by
> other drivers parsing the MIPI definitions extracted from firmware
> tables (ACPI or DT).

Applied, thanks

-- 
~Vinod
