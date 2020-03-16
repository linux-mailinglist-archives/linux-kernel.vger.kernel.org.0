Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2EBC186C94
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 14:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbgCPNxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 09:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731331AbgCPNxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 09:53:07 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17B0E2051A;
        Mon, 16 Mar 2020 13:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584366787;
        bh=jn9DQLmhvMfNUXlsfJreWd0dGysvpMQDHepheL0R1TQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=O9kxdVIoMmZ6+sx70kPcmm9vDWQisTaT21RiteVADlWLPIwcJwkoIeR3f8LU+BRWr
         ikPCZSbvo77V3IBzE4r80i0SyyQOmlxQj907k0L12xoyeC+tRWBr3agAnJibvjb1Wp
         PUktWrYnzk49lF2fVKuv+3Bf32NF3e4+WBrz9wdQ=
Date:   Mon, 16 Mar 2020 14:53:03 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Chen-Tsung Hsieh <chentsung@chromium.org>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, drinkcat@chromium.org
Subject: Re: [PATCH] HID: google: add moonball USB id
In-Reply-To: <20200316072419.65274-1-chentsung@chromium.org>
Message-ID: <nycvar.YFH.7.76.2003161452520.19500@cbobk.fhfr.pm>
References: <20200316072419.65274-1-chentsung@chromium.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Mar 2020, Chen-Tsung Hsieh wrote:

> Add 1 additional hammer-like device.
> 
> Signed-off-by: Chen-Tsung Hsieh <chentsung@chromium.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

