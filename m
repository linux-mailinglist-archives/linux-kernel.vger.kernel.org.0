Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F35713A0FF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 07:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgANGdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 01:33:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgANGdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 01:33:20 -0500
Received: from localhost (unknown [49.207.51.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 095E620678;
        Tue, 14 Jan 2020 06:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578983600;
        bh=KMrOVHv1qWtzxvvNmnvYPUneA1sRJDbNdAG71gbQ56A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xPVWTHDVqhRNWraqNh1zTEH85tOBtOHAgdj08l5WQJiSwCafKOHkFh+rn7xOIwLsZ
         ebGSN0iXI6DPh4yidBJ2BQsQxcRcJ3p96gflQsWg2syKfcFvkkC+Ax3GQ9C8uRd132
         mEo4LRY/1lSBmpIdpGfs+tBlyljLL0wZZbnCi4Bw=
Date:   Tue, 14 Jan 2020 12:03:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH 0/2] soundwire: cadence: remove warnings
Message-ID: <20200114063300.GF2818@vkoul-mobl>
References: <20200113211025.27973-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113211025.27973-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-01-20, 15:10, Pierre-Louis Bossart wrote:
> Fix warnings reported by cppcheck and make W=1

Applied, thanks

-- 
~Vinod
