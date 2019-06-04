Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C284D34969
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 15:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfFDNvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 09:51:20 -0400
Received: from foss.arm.com ([217.140.101.70]:44488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbfFDNvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:51:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 576C9341;
        Tue,  4 Jun 2019 06:51:19 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 474AA3F690;
        Tue,  4 Jun 2019 06:51:18 -0700 (PDT)
Date:   Tue, 4 Jun 2019 14:51:15 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Liu Song <fishland@aliyun.com>
Cc:     will.deacon@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, liu.song11@zte.com.cn
Subject: Re: [PATCH] arm64: kernel: use aff3 instead of aff2 in comment
Message-ID: <20190604135115.GF6610@arrakis.emea.arm.com>
References: <20190601020808.3091-1-fishland@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190601020808.3091-1-fishland@aliyun.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 01, 2019 at 10:08:08AM +0800, Liu Song wrote:
> From: Liu Song <liu.song11@zte.com.cn>
> 
> Should use aff3 instead of aff2 in comment.
> 
> Signed-off-by: Liu Song <liu.song11@zte.com.cn>

Queued for 5.3. Thanks.

-- 
Catalin
