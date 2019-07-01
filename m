Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE113E474
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 16:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfD2OQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 10:16:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58216 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfD2OQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:16:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CE9FA78;
        Mon, 29 Apr 2019 07:16:10 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBED53F5C1;
        Mon, 29 Apr 2019 07:16:08 -0700 (PDT)
Date:   Mon, 29 Apr 2019 15:16:03 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] regulator: vexpress: Get rid of struct
 vexpress_regulator
Message-ID: <20190429141547.GA13159@e107155-lin>
References: <20190429113542.476-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429113542.476-1-axel.lin@ingics.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,

On Mon, Apr 29, 2019 at 07:35:41PM +0800, Axel Lin wrote:
> The *regdev and *regmap can be replaced by local variables in probe().
> Only desc of struct vexpress_regulator is really need, so just use
> struct regulator_desc directly and remove struct vexpress_regulator.
>

Looks good, thanks for the clean up.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
