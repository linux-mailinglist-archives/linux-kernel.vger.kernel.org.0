Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D097A17B2DF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 01:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCFA1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 19:27:33 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:43871 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCFA1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:27:32 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48YT3733F8z9sRR; Fri,  6 Mar 2020 11:27:31 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f52153ab383f04a45c38d8a7f55a4249477b20df
In-Reply-To: <20191211160910.21656-2-sourabhjain@linux.ibm.com>
To:     Sourabh Jain <sourabhjain@linux.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     corbet@lwn.net, mahesh@linux.vnet.ibm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        linuxppc-dev@ozlabs.org, gregkh@linuxfoundation.org,
        hbathini@linux.ibm.com
Subject: Re: [PATCH v6 1/6] Documentation/ABI: add ABI documentation for /sys/kernel/fadump_*
Message-Id: <48YT3733F8z9sRR@ozlabs.org>
Date:   Fri,  6 Mar 2020 11:27:31 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-12-11 at 16:09:05 UTC, Sourabh Jain wrote:
> Add missing ABI documentation for existing FADump sysfs files.
> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f52153ab383f04a45c38d8a7f55a4249477b20df

cheers
