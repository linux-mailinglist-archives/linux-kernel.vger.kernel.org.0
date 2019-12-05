Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20A11113D7D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 10:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfLEJCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 04:02:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfLEJCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:02:38 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA035205ED;
        Thu,  5 Dec 2019 09:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575536557;
        bh=IegRoMB/1Q1fRaPPqw8Gvk6tJnrbo+VYNJkThGWkX78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hOAWg22NhSCrXMFC8ojXb8dJREu5nEV6aGcQg8f1YrwCh1LW7FM3d72d7RZ+mZHZa
         /4soWC1ihRSIBsdfmQkz3s0YiLdUpgVzWWRHGdAhRWlyOK4GBRB0jKRiW6Pm6gRBq0
         ZKiONXU6Fa+5gEsiYN/wqU8x/gAphf4z8YQjo2fc=
Date:   Thu, 5 Dec 2019 09:02:32 +0000
From:   Will Deacon <will@kernel.org>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, maz@kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        james.morse@arm.com, andrew.murray@arm.com, suzuki.poulose@arm.com,
        drjones@redhat.com
Subject: Re: [RFC 3/3] KVM: arm64: pmu: Enforce PMEVTYPER evtCount size
Message-ID: <20191205090232.GC8606@willie-the-truck>
References: <20191204204426.9628-1-eric.auger@redhat.com>
 <20191204204426.9628-4-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204204426.9628-4-eric.auger@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 09:44:26PM +0100, Eric Auger wrote:
> ARMv8.1-PMU supports 16-bit evtCount whereas 8.0 only supports
> 10 bits.
> 
> On Seatlle which has an 8.0 PMU implementation, evtCount[15:10]
> are not read as 0, as expected. Fix that by applying a mask on
> the selected event that depends on the PMU version.

Are you sure about that? These bits are RES0 in 8.0 afaict, so this would be
a CPU erratum. Have you checked the SDEN document (I haven't)?

Will
