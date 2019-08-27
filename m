Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53B5F9E828
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 14:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfH0MlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 08:41:24 -0400
Received: from mout.web.de ([212.227.17.12]:35699 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfH0MlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566909655;
        bh=sljqHy1iT8wDeq/FieHO424nJ0qcdwXpNPoCFzDQxZA=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=Z5MuYxsb/t3lxh70q84ilGUZ5PnsgRo8ZKUANZEW8Uib8YeICzNxnr+eV7ZevxKy+
         cw7cCZXwSOASkgG9/M/F4NnLEkAuC/P+cNYJbSt4MCMSVHw2lNJ/wlTeLnK/nYZu7S
         zNrMdfQNsm6hckRI8A9LfLz28bBLyXkMhrGliwqc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.143.232]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lx7Ab-1iHukI2Aaf-016cmA; Tue, 27
 Aug 2019 14:40:55 +0200
To:     linuxppc-dev@lists.ozlabs.org,
        Allison Randal <allison@lohutok.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Frank Rowand <frank.rowand@sony.com>,
        Gen Zhang <blackgod016574@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] PowerPC-pSeries: Adjustments for dlpar_store()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Message-ID: <db28c84d-ac07-6d9a-a371-c97ab72bf763@web.de>
Date:   Tue, 27 Aug 2019 14:40:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oTsH/DEt6X/0F9zv7bGbHxNwZ0bjYrijS2DP38xVB6eZlvFss2k
 qX70p2NNWaP9q3ck8qr2w9yJaeW7dL8fMBDt3jp+GRdm7ztkMDjFNMC7TVdRXPcQEw6QVLK
 YhIMyqdJ7L2CqUR/R7de8k5ng1GMcJ18zG0VgJKDbNwZVsz1D4jGSOF2eZIhc3Vsmli2Bj3
 al9ZtAfaco+RqR+2Q/XOA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jduo0XaI+b0=:q36t37oyGOoiLEMbH5EGN6
 +tjm+3oFeyZUjaqIKrqSXefSB0iN442nJr76wr2K2FqJ75ARR1/ntKS/9233P+U0fvavtsSug
 lv7Qaf+9kC4E4hG8kduaq7k5okwai0Od704/3Qqf6lblIYCeYYRoUn07bvN0PguwoLhgzwKEJ
 w1lKShUZBl/rI9fs7JndkGras+9Zpraz7KznzWF+zz7SJkXqrSvuXeFwarOp2Bcqv3ZlhY4gh
 K5S180RGdIcOlt/2ufcfMYRLebOsaAhIloeGuuwprj8JYDhYAAaIx9beRp9U5eRSe1UylTDYw
 qr/cxxuDssNH0HEBF0SMDsflQzUTIKTDmk6eoM9HZElmST4SWxTt2fbIERDYkLndXINT/dTr/
 i7Bcqderc1113SADIN22PSxZnSG+c0thKp3jtGNQ4HtB8U9Tvm2SCC91DtNpwVo99hiuJ7cpt
 4j0kaXRc+KblY/k+B5lMhqr9Jj62Jm0ae63O+TavIyB22AolIAg8f/1GqRFXdd8+EJO/jg9E1
 AsDhqDiWc7JR8w/JBVzTJ6ASRZSNdVycOwqVuIrrpI5RGBO7BFS9y1XSywiAs9ds1vZG8AFhI
 ielmH5OwsomTZSX0TGXsz36EHLSpqFHS7Fo9ZPmxJhdOBrqfyMnWP/UwXeoteG0J33af6hLQr
 EkChbYc0rRP3zkj9zQE6CHATxvUVhRMI0xj/EeRJAYQ7DSlGeISFRZj7Imab34gdSCFpDphbL
 cXS9G0hPaub7UdJHKHg3KNDvX7RGpPLZzzL71Ns0OhU4eAoqE46wFD3etpeg1LoRlHrzC+iss
 zHKkdCo1nlV7bkiCmTUHK27BAqX+8jrCZun92IKEJTtikF1OGCNuj2uvkgdQl02TeGhmEJ7wq
 bd2TWO7iEUTcQxQeRTxRr4UydAyj7TR2sq0l1QCmc60rEOgmt9aMusEoE0xtQvXePgnPlyzHq
 tglzLpvx5KKuQG7m7ijWFn37pCKq4C+qqJGCnDzNaANXo1ABtO9W6673lLWq9G1cT25/fJTZq
 f3q4pKvD4bwosNQXsiWKksnSu86i3N6QhPm0Gt9Z2jYL2hF/xL8gJxTQ9WiTbgE5JEEa1asIe
 xG5QZxDX8bNfuL/NQ3GIxPiExA8vIYcDCx2tuPbgt5cUHb3v2qU3KOTCdckZuApbeHqqNaysZ
 Y4HhU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 27 Aug 2019 14:33:21 +0200

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an unnecessary kfree() call
  Delete an error message for a failed string duplication

 arch/powerpc/platforms/pseries/dlpar.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

=2D-
2.23.0

