Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 658CA3032D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 22:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfE3UPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 16:15:38 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:49032 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfE3UPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 16:15:37 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 6AC22115;
        Thu, 30 May 2019 22:15:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1559247336; x=1561061737; bh=/1Bzoci3zr3geDjPVfIzzdq7YP8QSh/pZWF
        AI555y5M=; b=D8isbIjouobMFUizV9cdTIEPAN1DIQ7XL5AHjKR6YvRJerFhTrY
        vX5hUOvVSk/DKZbb7DNabHp0WdPyXB9Vsh+7IA7A2ZZlVbHisu1oXX7EUw0dwais
        zctFNidjZi24oSg7n4cr1qWuAivofMM09s6rKeod0IYLJeLKQZuCG9ftsD5CtCI5
        DPQzg6SH1TaP4twrNkzxmsbrtOfolIcDVRszfNNG9RFlKMfrRvznZwK20Gad6IaY
        0fSxoe0gsgtxw9ea7KDgVXqmofJv+iAKey4jPB2hnLtsCTjnBiiRfPWJ3A5OvNDE
        QyxzXZAcyoBjLefAN8nxR+qyBs6n6DAWRgfzDV/tJu8u6p1kL78VgoQV0PAXuub1
        eWSU9CX5z+01Uyd8awKavL92qwyEUY4GZA4+suk4sVAjH9LJsxdZ72rlLrSepNiO
        WxJZKttnEBnyp6l4FiTwoA6tCvee2m2S0PlmW8kbfus5JufhGictzYvcBDAabREG
        wlrKKxl1jhmymw/O8bqVJeATfw2hIUaE3EWPbd1Y2yz43amD2DY1oxcRiYAxbFTF
        4hMGr/1tACSYpoxiAljrZRiMMENlyGwpuEeTB+DFTOnSMs/XHH0JQb38G6zwEuQv
        wMI3VwrUOItwcpSo2V0wp+GgTYJhON85MPg5puLUrfCeaqf7iNe9mKuk=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZOAcdX_iOcnK; Thu, 30 May 2019 22:15:36 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id F006EC8;
        Thu, 30 May 2019 22:15:35 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 80BCC2B3C;
        Thu, 30 May 2019 22:15:35 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>
Subject: Re: [PATCH 06/22] doc: it_IT: fix reference to magic-number.rst
Date:   Thu, 30 May 2019 22:15:34 +0200
Message-ID: <1738585.bzCz3vHTFA@harkonnen>
In-Reply-To: <76713fe801e082e54e4412331d14495f2620ee59.1559171394.git.mchehab+samsung@kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org> <76713fe801e082e54e4412331d14495f2620ee59.1559171394.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 30, 2019 1:23:37 AM CEST Mauro Carvalho Chehab wrote:
> There's a typo at the referred file.

I am about to send a patch that fixes all issues found by
documentation-file-ref-check in Documentation/translations/it_IT.

Of course I fixed this as well.

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/translations/it_IT/process/magic-number.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/translations/it_IT/process/magic-number.rst
> b/Documentation/translations/it_IT/process/magic-number.rst index
> 5281d53e57ee..ed1121d0ba84 100644
> --- a/Documentation/translations/it_IT/process/magic-number.rst
> +++ b/Documentation/translations/it_IT/process/magic-number.rst
> @@ -1,6 +1,6 @@
>  .. include:: ../disclaimer-ita.rst
> 
> -:Original: :ref:`Documentation/process/magic-numbers.rst <magicnumbers>`
> +:Original: :ref:`Documentation/process/magic-number.rst <magicnumbers>`
> 
>  :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
> 
>  .. _it_magicnumbers:




