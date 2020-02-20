Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E84A166070
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 16:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgBTPHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 10:07:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbgBTPHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xKyvjqimRhAfHNzc+cm9xUmz5X2g3qnb/GGXUeEIccs=; b=XaoXki0a+xPaireJc0n1WrxqFP
        5lYjP03AKiRq2/5VRCpWreksIs5vu+jk/i6A9fHWKOAUdqdLBapXXLxPgXBnPt40t7KqtioVADU8J
        IMGJHRpvG8+VLEJ2QQL8Yw3PRVKKHvkkPCpPb7pagbB8tG0gWyMNH+DcyimYPM6ycMxurIYsdaoxu
        eYb454DyHbnxKieS3mpJtMperBPet91W7Rc/fBieLrZrZUTWLRebEhRgH9HODYZJGj3PU7FayfaGP
        wn/Zt3/SeGkFQtRFi8TllZw1yh8GYZrI3AYVX1oEBinPnHHZsQZsUxf9bhPtSuHpH3SzyiWOgM8GX
        aMfmwEvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4nPp-0005xE-Vu; Thu, 20 Feb 2020 15:07:01 +0000
Date:   Thu, 20 Feb 2020 07:07:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: drm_dp_mst_topology.c and old compilers
Message-ID: <20200220150701.GA12594@infradead.org>
References: <20200220004232.GA28048@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220004232.GA28048@paulmck-ThinkPad-P72>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 04:42:33PM -0800, Paul E. McKenney wrote:
> -	struct drm_dp_desc desc = { 0 };
> +	struct drm_dp_desc desc = {{{ 0 }}};

Does:

	struct drm_dp_desc desc = { };

work for your geriatric compiler?
