Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5525F11C32A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 03:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfLLC0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 21:26:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:41508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbfLLC0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:26:13 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68EAE20836;
        Thu, 12 Dec 2019 02:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576117573;
        bh=K68g+kmy7MhWwVPsvU51fx2UEqW5IccJ7F4C9TARcNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LX5f4cKS0lCAVpGggGOvvujQd479nF/SRRkYp1jkedWP7ca/4Pph3C9LVWF7wHr8B
         YKck5OitZX++epSOOYIWU5OvjF+jYhbCQrV04+GmLpQugKygsMWrOofysoMDwqw8lj
         oqQCKIDACmJ6m9IomXwWATkvJnZq9CNQ+yp9I0sg=
Date:   Thu, 12 Dec 2019 10:26:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: vf610-zii-dev-rev-b: Drop redundant I2C
 properties
Message-ID: <20191212022559.GF15858@dragon>
References: <20191211134957.30587-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211134957.30587-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 05:49:57AM -0800, Andrey Smirnov wrote:
> ZII VF610 Board Rev. B is supposed to have exactly the same I2C config
> as Rev. C, including I2C bus recovery settings. Drop redundant I2C
> properties that are already specified in vf610-zii-dev.dtsi
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied, thanks.
