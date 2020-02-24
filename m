Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A84F16A493
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 12:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgBXLFP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Feb 2020 06:05:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:51596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgBXLFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:05:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8CB37ACD6;
        Mon, 24 Feb 2020 11:05:13 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     L Walsh <cifs@tlinx.org>, linux-cifs <linux-cifs@vger.kernel.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Regression -- linux 5.5.3: can no longer mount with unix
 extentions using cifs 2.1 (Win10-only client additions)
In-Reply-To: <5E51DAEA.8090702@tlinx.org>
References: <5E51DAEA.8090702@tlinx.org>
Date:   Mon, 24 Feb 2020 12:05:11 +0100
Message-ID: <87blpo5jq0.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

L Walsh <cifs@tlinx.org> writes:
> Unix extensions worked long before SMB3.x.  It seems there is ongoing work
> to disable SMB2.1 support and replace it with only latest SMB from MS
> compatible with Win10. 

* UNIX extension are smb1 only and are only implemented by the Samba
  server (not windows).
* POSIX extensions are for smb2+ and are still experimental.

The fact that serverino gets disabled looks like a bug. As Steve said,
the problem seems to be related to ACL.

You should open a bug and provide dmesg and network capture as
documented here:

https://wiki.samba.org/index.php/Bug_Reporting#cifs.ko

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
