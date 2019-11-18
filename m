Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FED0FFC96
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 01:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfKRAxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 19:53:34 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:42221 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfKRAxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 19:53:34 -0500
Received: from obelix.fritz.box ([46.142.26.89]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mzi3l-1haqGz1w81-00veRL for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019
 01:53:32 +0100
To:     linux-kernel@vger.kernel.org
From:   "fedorauser@online.de" <fedorauser@online.de>
Subject: Re: Linux 5.4-rc8
Message-ID: <c4bbe72d-6363-08c6-69c3-c70764354b7c@online.de>
Date:   Mon, 18 Nov 2019 01:53:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:cA/2UMSOl7TEpDwugT05/IRIGw8fXpysUagvi7uSmg4VvwBv90q
 l7YFujfOB2ENAPwTRkHAz7QP45y+9DgDeTaLZE1miZtxLdxv1qOiBH7LcZme+0+p2zRylA/
 DxbdEDQglmf4zxwnc6Zb38xCjMKor3xp0t7mMBNU4DG3TE0r4dSOHk2n9Rpy8wJelflZrDT
 vOntpVS4m6nJBMRBakcUQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UFyhRDCsupQ=:JjzUaABGHuhf+/OMjeSiBM
 l2bLKOOrQU2baFXpiqnhX2E55mfEEIeBO2IKYUSH1oka1FlcwB2tykpu9Y+68RQAwuvYDpm/p
 aLq78FEMyyiH2hIcAMh08rnGiAOkV+hYBiL5rMrc7Jq0gHxdM0JvQKGjPN9L558/ol7dcoiEL
 4oSEcZSuwEolNE2c4vakmbDuGMtV0UgPdd+2eDYiUu7JAQ4BDYSDVUPWv9k78PcFUk2jhHzzz
 Nzxx7RT9pzZti7xmSXp9fcrwOJorJpdAnhmDCEr1WZ2mtTD4bUVNIAcN1yOnK553wk0Tk6zM4
 7lnnImLCeCuLQ7hBif057/o3p+Fgwoz6Xz4fDhseTjZiOpT1vGW1hpFSKT17+mM7VXqjZwP/K
 JfmM/ZihEZH/d9wB/ZzzZz4FBD6gGJjhWBqNhkM9ny6Cs0sEBKwT+EoVYHGs+bNdymVG5qPaC
 4mTSHx/qaATw7+KGoaMbAMMzILpjj56Z/t5jJ4+STtd/G4DVY0qpelaLWW2YbFHgUnXAtmuWV
 fCvBGOqMsSmZlFVe1RVBjdEGj3Qe1FwmGB4LE1lZKH4rN4oAW1zoyZtu+/O+QXYn/yxStvYOz
 P7FuJ+bGgAhdj7UmtsvoTdkKEj8iPaxdlmbYzQmurPSMuo2JMF29o1poZ1E98kDraj7fmYkO8
 8cYRvAUniFKlsf1PWMtQlpFcnoPaptBi9tx9cLuhoZu+v4g1SgaOVeESeFicts2QwmgbMiktM
 ZnZ4YyZzcO4+itR6sfZn+2cvYtUgc8ipT1IG7GL5qAkG+NpdIxD2I8HzZtR/cViphAu7tsrNY
 raPrMfkX1pg4WsMAY+GbgYwXhRdtNdtf7RlDxqmixXm6G3MXkV+vQEG1ayeyYdr1VMq+RH3si
 g1qvGPov+QRkcf9/efAsQhFOtDNwVJWXpc3NkJfm4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hallo

with Kernel 5.4-rc7 and 5.4-rc8


I see this:

awk: ../arch/x86/tools/gen-insn-attr-x86.awk:260: warning: regexp escape 
sequence `\:' is not a known regexp operator
awk: ../arch/x86/tools/gen-insn-attr-x86.awk:350: 
(FILENAME=../arch/x86/lib/x86-opcode-map.txt FNR=41) warning: regexp 
escape sequence `\&' is not a known regexp operator


It seems it was fix already:

https://www.lkml.org/lkml/2019/10/1/232


regards

-- 
sixpack13
