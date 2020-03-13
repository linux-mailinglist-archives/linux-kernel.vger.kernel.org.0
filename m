Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFF171846FF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 13:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCMMho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 08:37:44 -0400
Received: from foss.arm.com ([217.140.110.172]:54378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgCMMho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:37:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAD9030E;
        Fri, 13 Mar 2020 05:37:43 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16F843F534;
        Fri, 13 Mar 2020 05:37:42 -0700 (PDT)
Date:   Fri, 13 Mar 2020 12:37:41 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Kconfig: allow to change FORCE_MAX_ZONEORDER via
 custom config
Message-ID: <20200313123741.GC3857972@arrakis.emea.arm.com>
References: <20200312235037.26072-1-vadym.kochan@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312235037.26072-1-vadym.kochan@plvision.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 01:50:37AM +0200, Vadym Kochan wrote:
> Add missing config option name which allows to change it via custom
> config.

Why? What is your use-case?

-- 
Catalin
