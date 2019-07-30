Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5D27AC92
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 17:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbfG3PmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 11:42:25 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:55100 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725209AbfG3PmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:42:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 1EC41FB03;
        Tue, 30 Jul 2019 17:42:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CtUgzmSSelqj; Tue, 30 Jul 2019 17:42:22 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id D273946BB5; Tue, 30 Jul 2019 17:42:21 +0200 (CEST)
Date:   Tue, 30 Jul 2019 17:42:21 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Fix generated example files getting added
 to schemas
Message-ID: <20190730154221.GA379@bogon.m.sigxcpu.org>
References: <20190730145935.26248-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190730145935.26248-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Jul 30, 2019 at 08:59:35AM -0600, Rob Herring wrote:
> Commit 837158b847a4 ("dt-bindings: Check the examples against the
> schemas") started generating YAML encoded DT files to validate the
> examples against the schema. When running 'make dt_binding_check' in
> tree after the 1st time, the generated example .dt.yaml files are
> mistakenly added to the list of schema files. Exclude *.example.dt.yaml
> files from the search for schema files.
> 
> Fixes: 837158b847a4 ("dt-bindings: Check the examples against the schemas")
> Reported-by: Guido Günther <agx@sigxcpu.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index 6b0dfd5c17ba..5138a2f6232a 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -19,7 +19,9 @@ quiet_cmd_mk_schema = SCHEMA  $@
>  
>  DT_DOCS = $(shell \
>  	cd $(srctree)/$(src) && \
> -	find * \( -name '*.yaml' ! -name $(DT_TMP_SCHEMA) \) \
> +	find * \( -name '*.yaml' ! \
> +		-name $(DT_TMP_SCHEMA) ! \
> +		-name '*.example.dt.yaml' \) \
>  	)
>  
>  DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))


this fixes checking twice in a row for me. Thanks!

Tested-by: Guido Günther <agx@sigxcpu.org>

 -- Guido

