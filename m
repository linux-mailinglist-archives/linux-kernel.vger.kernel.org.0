Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 360551180D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 13:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfEBLOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 07:14:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfEBLOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 07:14:19 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDCC22085A;
        Thu,  2 May 2019 11:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556795658;
        bh=MqSM/5wasmKXT+b68M46Usp85QV58pt4Y2LMtKcDYD0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=CVL8AUfaMlqtqzUsH7Q5m5WMAD2PxtWIsv409mBRcHZlbQz9gSrCLswLUg5WDnUWW
         W31iH8wcLy/MUxPaJ9IKl32xoIlJR0lCJrKIYF4FzP5zp2ihMrHfRq+mbpOsCE6tq/
         Y1TOobSnFLk7UYU0iEJ9ia0ukLnsUh8rRnLDsdrY=
Date:   Thu, 2 May 2019 13:14:04 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        bleung@chromium.org, groeck@chromium.org, ncrews@chromium.org,
        jettrink@chromium.org, gwendal@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] platform: chrome: Add ChromeOS EC ISHTP driver
In-Reply-To: <8d90cf3cdce456e206a54c75c1c35ae5b8c1f6b6.camel@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1905021313350.10635@cbobk.fhfr.pm>
References: <1555496317-16616-1-git-send-email-rushikesh.s.kadam@intel.com>  <9b4dcd74-5cb4-c7ac-d8be-ed47db35fa87@collabora.com> <8d90cf3cdce456e206a54c75c1c35ae5b8c1f6b6.camel@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019, Srinivas Pandruvada wrote:

> +Jiri
> 
> He is not copied.

Could you please resubmit the final version, and CC linux-input@ and 
Benjamin Tissories as appropriate?

Thanks,

-- 
Jiri Kosina
SUSE Labs

