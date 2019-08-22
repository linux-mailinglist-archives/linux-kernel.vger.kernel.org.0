Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9FB99188
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 13:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387949AbfHVLAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 07:00:54 -0400
Received: from foss.arm.com ([217.140.110.172]:43836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731126AbfHVLAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 07:00:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B12DC344;
        Thu, 22 Aug 2019 04:00:53 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2E803F246;
        Thu, 22 Aug 2019 04:00:52 -0700 (PDT)
Date:   Thu, 22 Aug 2019 12:00:50 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Florian Weimer <fweimer@redhat.com>, binutils@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: ELF NT_GNU_PROPERTY_TYPE_0 Questions
Message-ID: <20190822110049.GE27757@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Can you clarify a couple of points about the SysV ABI Linux
Extensions [1] for me?

1) Can there be more than one NT_GNU_PROPERTY_TYPE_0 note in a valid
ELF file?  I think the answer should be "no".

2) Is is permissible for an ELF ET_EXEC or ET_DYN file that contains
an NT_GNU_PROPERTY_TYPE_0 property not to have a PT_GNU_PROPERTY phdrs
entry mapping it?  Except for historical usage by RedHat (which
apparently can be worked round in userspace) it seems reasonable for
the answer to be "no", at least for Linux.

3) Is it permissible for the PT_GNU_PROPERTY phdr (if present) to
map anything other than precisely one NT_GNU_PROPERTY_TYPE_0
note?  I think the answer should be "no".

4) Is an NT_GNU_PROPERTY_TYPE_0 note allowed to contain two or more
properties with the same pr_type?  I think the answer should be "no".

5) What's the rationale for sorting the properties by pr_type?  I can
see this would make it easier for the linker to merge
NT_GNU_PROPERTY_TYPE_0 notes from different files, but I'm wondering
whether the kernel really needs to enforce the ordering when loading
an ELF.  The kernel doesn't need to merge property lists together.

6) Do you have a view on the best way to define the Elf_Prop type in
headers?  bfd elf-bfd.h seems to have elf_property, but this doesn't
follow the style of the public ELF headers.

Maybe Linux should keep its definition internal rather than publishing
it in include/uapi/elf.h...  I'm not sure.

Thanks
---Dave

[1] Linux Extensions to gABI
https://github.com/hjl-tools/linux-abi/wiki/Linux-Extensions-to-gABI
