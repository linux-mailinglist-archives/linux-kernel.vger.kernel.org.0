Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAFC185751
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 02:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgCOBgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Mar 2020 21:36:19 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:44540 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgCOBf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:35:59 -0400
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 1B2BF200B48;
        Sat, 14 Mar 2020 13:46:05 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 1EC0420834; Sat, 14 Mar 2020 14:43:56 +0100 (CET)
Date:   Sat, 14 Mar 2020 14:43:56 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v4 10/18] x86: Remove syscall qualifier support
Message-ID: <20200314134356.GE453554@light.dominikbrodowski.net>
References: <20200313195144.164260-1-brgerst@gmail.com>
 <20200313195144.164260-11-brgerst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313195144.164260-11-brgerst@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 03:51:36PM -0400, Brian Gerst wrote:
> Syscall qualifier support is no longer needed.
> 
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
