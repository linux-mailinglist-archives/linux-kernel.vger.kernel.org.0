Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C980D1870A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 10:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfEIIuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 04:50:11 -0400
Received: from foss.arm.com ([217.140.101.70]:34590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfEIIuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 04:50:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29FC7374;
        Thu,  9 May 2019 01:50:10 -0700 (PDT)
Received: from C02TF0J2HF1T.local (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9BB13F575;
        Thu,  9 May 2019 01:50:08 -0700 (PDT)
Date:   Thu, 9 May 2019 09:50:04 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Salman Qazi <sqazi@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: icache_is_aliasing and big.LITTLE
Message-ID: <20190509085004.GE64514@C02TF0J2HF1T.local>
References: <CAKUOC8WxRnzeMEcS-vao-GOzXnF+FN+3uk8R6TspRj23V7kYJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKUOC8WxRnzeMEcS-vao-GOzXnF+FN+3uk8R6TspRj23V7kYJQ@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 08, 2019 at 11:45:03AM -0700, Salman Qazi wrote:
> What is the intention behind icache_is_aliasing on big.LITTLE systems
> where some icaches are VIPT and others are PIPT? Is it meant to be
> conservative in some sense or should it be made per-CPU?

It needs to cover the worst case scenario across all CPUs, i.e. aliasing
VIPT if one of the CPUs has this. We can't make it per-CPU because a
thread performing cache maintenance might be migrated to another CPU
with different cache policy (e.g. sync_icache_aliases()).

-- 
Catalin
