Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B1B15A89E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 13:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgBLMDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 07:03:38 -0500
Received: from mailomta12-re.btinternet.com ([213.120.69.105]:38858 "EHLO
        re-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbgBLMDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:03:37 -0500
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20200212120334.PPOK16580.re-prd-fep-047.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Wed, 12 Feb 2020 12:03:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1581509014; 
        bh=kHGdWcUTXHR3UL14kLf9Zry9N63KEVIVP1LWL5DkSqQ=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=WtlM0Xyht+vuAwdt/l8f1czhehZX34hzsp9kCVtmGoM91BcQRd0eVw0SfDA0hgWa4i+Q2A5EN/3fG1KpGHmDPkyLvwio5Yt7/2GLYX38G7p47HyhlMR69Q2vT9cWk88EcPVevMNPocTs3T+BX3Bjg+4jTOaRenLqqO27ATrF8XEPKXPiOI/HWuOd5Fd5LY+GnAlIb1jbqTKRt5nuWZw2CzeqXqWzQCEH2pRwa7rWmB5hUrZV6ABquYod3KE7x+1euxIGk0q1njvgF6MXQs5U37Z3PDwVTWPtIQjkE/LlteHp1jiTSzUBD95vvFHD2XRIoUo/kDKIisuNnEnNpXOBZw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.60.248]
X-OWM-Source-IP: 31.49.60.248 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrieehgdefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeefuddrgeelrdeitddrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdegledriedtrddvgeekpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotghgiihonhgvshesghhoohhglhgvmhgrihhlrdgtohhmqedprhgtphhtthhopeeoughhohifvghllhhssehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehlihhnuhigqdhnvgigthesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthho
        peeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsfhhrsegtrghnsgdrrghuuhhgrdhorhhgrdgruheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.60.248) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A181A01289E90; Wed, 12 Feb 2020 12:03:34 +0000
Message-ID: <1d0b80d272a8e8c4a7b322d2d2bcc483d9e41a28.camel@btinternet.com>
Subject: Re: linux-next: manual merge of the selinux tree with the keys tree
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Paul Moore <paul@paul-moore.com>,
        David Howells <dhowells@redhat.com>, sds@tycho.nsa.gov
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian =?ISO-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Date:   Wed, 12 Feb 2020 12:03:33 +0000
In-Reply-To: <20200212103548.266f81fd@canb.auug.org.au>
References: <20200212103548.266f81fd@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-12 at 10:35 +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the selinux tree got conflicts in:
> 
>   security/selinux/include/security.h
>   security/selinux/ss/services.c
> 
> between commit:
> 
>   87b14da5b76a ("security/selinux: Add support for new key
> permissions")
> 
> from the keys tree and commit:
> 
>   7470d0d13fb6 ("selinux: allow kernfs symlinks to inherit parent
> directory context")
> 
> from the selinux tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your
> tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any
> particularly
> complex conflicts.
> 

I think 87b14da5b76a ("security/selinux: Add support for new key
permissions") should be revoked and resubmitted via selinux as it was
never ack'ed there and produced before 7470d0d13fb6 ("selinux: allow
kernfs symlinks to inherit parent directory context"), that has been
ack'ed.

Because of this the policy capability ids are out of sync with what has
been committed in userspace libsepol.

Plus as Paul mentioned there is an outstanding query on the permission
loop that David needs to answer.



