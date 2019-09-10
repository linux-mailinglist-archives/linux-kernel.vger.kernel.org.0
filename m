Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F668AEE3D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 17:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393886AbfIJPMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 11:12:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:60999 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393861AbfIJPMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:12:18 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x8AFBrQS016611;
        Tue, 10 Sep 2019 10:11:53 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x8AFBqhw016608;
        Tue, 10 Sep 2019 10:11:52 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 10 Sep 2019 10:11:52 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] powerpc/kexec: move kexec files into a dedicated subdir.
Message-ID: <20190910151152.GV9749@gate.crashing.org>
References: <68d12eb0b815049049babc9be243ffd8521b48c7.1568127294.git.christophe.leroy@c-s.fr> <9019b24c1f6ed838550669135fcaa9493670e188.1568127294.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9019b24c1f6ed838550669135fcaa9493670e188.1568127294.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 02:55:27PM +0000, Christophe Leroy wrote:
> arch/powerpc/kernel/ contains 7 files dedicated to kexec.
> 
> Move them into a dedicated subdirectory.

>  arch/powerpc/kernel/{ => kexec}/ima_kexec.c        |  0
>  arch/powerpc/kernel/{ => kexec}/kexec_32.S         |  2 +-
>  arch/powerpc/kernel/{ => kexec}/kexec_elf_64.c     |  0
>  arch/powerpc/kernel/{ => kexec}/machine_kexec.c    |  0
>  arch/powerpc/kernel/{ => kexec}/machine_kexec_32.c |  0
>  arch/powerpc/kernel/{ => kexec}/machine_kexec_64.c |  0
>  .../kernel/{ => kexec}/machine_kexec_file_64.c     |  0

The filenames do not really need "kexec" in there anymore then?


Segher
