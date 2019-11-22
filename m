Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B11DE107802
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 20:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKVT3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 14:29:10 -0500
Received: from sonic304-10.consmr.mail.bf2.yahoo.com ([74.6.128.33]:40601 "EHLO
        sonic304-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726695AbfKVT3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574450947; bh=FV1waOWroAVjEnN/rWoqGnF6OwY1eg/3wC8sp7AN1X4=; h=Date:From:Reply-To:Subject:From:Subject; b=UqyKeHUltXBgyrOAtuHCLi7rIGOMmhcgc63KGqDLXw9DyOdiRGZo8Hz5FpnjKd9nIIYO6cqPC1JtLcTeY6QgrStfz2I7/CSbczIm0H9u49dlmDHYqxJFHstEepAIfFH5iKbhtv0TvTFp0fl+EAn5EPOr91PywDxWKFf91RW0+T31aQZqPQthSEb15BB6Wck87fCOmX+t+8TtcLmK/pvh5mZlRvvNoGYRNZEu+xfaXtgK4hwqTW8q2TTODDjMCyIFp97gh5Lj33rwgYyEGFKl6SB700EfpfV9aHriAC33t8C1Vpgno5RX/6InBCaD2InAm9Jlazpi9I8S5DKJU6473g==
X-YMail-OSG: hfyTRU0VM1nRjCjvZgstFmNl1ixN7pJSc1Sxsd_H_mHT4xsSibCS.BnQRGQCA1M
 3izmg1.QpjQrCYS_0.C.5DPusx6a5uaVlhxV7ts.HOReIscO0KlcFtKKsFkonfl7yCG9nqmCugeg
 FETczbAhzgfq_pThEvxboi2RJB16xepcoCNDZODlTv3ESIDiU0BseR_BXNHlOM_cQZo6AIGoVut3
 8bkG5ipRiBdgp.4q.557X7IzLbEq6lxQE71olhgEv2ASVEEB7zMVIVb2aMjRkTAXqbuMLWdjsHH9
 l8dd20j4EX2EcInpdbvs40iXDFBMoR783K0eIRinauRL4SaUBlsB_Jpmix5UlFJsFnwma9VH4M3Y
 jtbKvrYtjL5kbSpRVmzsEimKAzzQxVe4ZpnYiftmiPW_BXIKgkGyTuRMG_xwclpUk5ejRycs4pUD
 AXde1FkJlcShJ0UDjVziDIUQtGvJUGy5HTPRC140Gnj1aTqph1keOZfV_rT.JpvXVQHzB0qvlxUR
 0mJBhIvHXh1Uf.peQDvWEW53KIPrjTsgmXBwitEwxzPkUIrNobjvm.rG3Tbez8kkwn.vNkR6Zg46
 BvcKwb00lkTgpfAy7eG6kcxE5NDz3HYE8u79w6c31gzOzRSo0tCGq2LR.c90xcneHQp0UL.ej1RB
 .xXfOuCpcrBPpXIxfANsLX75qbuOAFQ2x1Ug8MuhzQGuNKi5wPLbK5DReFEjAUZ7K2lgwYKGWdOV
 n8Bz20VF69P1fYVZFNgZkU8qZ7kQYZDtqgA9oJszW7NVVZjJN6rJ85dByzC.frcgqMcjqLvrd.Nf
 j0I0TfLmelWwLUNumxD83QtWRyaNw.eUXirPX405woUobbBBNHFjlrhfJK9LUUZcZTJY7QLzB9uV
 79DFGPCVK8KVEgF_Y4_ioD8UKCtDGsPKBUl7vspxusvPFMEXxF7TZE0fEXyjrFESSRiHkdm2bVLH
 1jechcX2PTixAl8DX1tC0390pXEK8uhlaFIyofE600y9ONpuHadhJdyjySWw6MfOs_OwF2zvF2kC
 J7J0dQyGuvp.kSQp5j9hGb3UOlSyXF3AEhThzrht0yn5b8Cvb4rUJb1ReGNNU5j0XUBRNA10MCbx
 TKuDby4WHPtBU.A10EkQmxi6E2m95YBrIbghiHAg5wu478GVoiUUT0ZcMO6d7VP0oMqbinYC6NVG
 _dZ7kSOmAiM1tuhos9h2AUIDptUYI8wmfeHaElC_IZKbeUupecMYrJPcbXd.S9mDVXhNeAG3fw2u
 LLsyOsUIxg3LwM5wUbEWugB4XnM0cg_InKpTnTbDj5sCC_5Do0ZicUpUt6wlwFF6Dvf_exMFlq.v
 wDRee7C2C
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Fri, 22 Nov 2019 19:29:07 +0000
Date:   Fri, 22 Nov 2019 19:29:04 +0000 (UTC)
From:   mohammado ouattara <mohammadouattara27@gmail.com>
Reply-To: mohammadouattara53@gmail.com
Message-ID: <1559326526.2727205.1574450944427@mail.yahoo.com>
Subject: I am expecting your urgent respond.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

I know that this message will come to you as a surprise. I am the Auditing and Accounting section manager in (BOA BANK) Ouagadougou Burkina Faso.

I Hope that you will not expose or betray this trust and confident that I am about to repose on you for the mutual benefit of our both families.

I need your assistance in transferring the sum of ($12.5M) Twelve Million, Five Hundred Thousand United Dollars into your account within 7 to 10 banking days,as one of my Bank clients who died at the collapsing of the world trade center at the United States on September 11th 2001.

If you are really interested in my proposal further details of the Transfer will be forwarded unto you as soon as I receive your willingness mail for a successful transfer.

I am expecting your urgent respond.

Have a great day,
Mr mohammad ouattara.




