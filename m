Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44AFD168363
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 17:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgBUQa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 11:30:27 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:47620 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgBUQa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:30:26 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id BC3DF2006D4;
        Fri, 21 Feb 2020 16:30:24 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 0364720AA0; Fri, 21 Feb 2020 17:30:17 +0100 (CET)
Date:   Fri, 21 Feb 2020 17:30:17 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] efi/libstub: describe RNG functions
Message-ID: <20200221163017.GA4477@light.dominikbrodowski.net>
References: <20200221114716.4372-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221114716.4372-1-xypron.glpk@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 12:47:16PM +0100, Heinrich Schuchardt wrote:
> Provide descriptions for the functions invoking the EFI_RNG_PROTOCOL.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
